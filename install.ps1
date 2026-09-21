$ErrorActionPreference = "Stop"

$repo = if ($env:SWAVAN_REPO) { $env:SWAVAN_REPO } else { "swavan/studio" }
$release = Invoke-RestMethod "https://api.github.com/repos/$repo/releases/latest"

function Get-Asset([string]$Pattern) {
  $asset = $release.assets | Where-Object { $_.name -match $Pattern } | Select-Object -First 1
  if (-not $asset) { throw "Required release asset not found: $Pattern" }
  return $asset.browser_download_url
}

function Find-Asset([string]$Pattern) {
  return $release.assets | Where-Object { $_.name -match $Pattern } | Select-Object -First 1
}

if (-not [Environment]::Is64BitOperatingSystem) {
  throw "The Windows installer currently supports 64-bit Windows only."
}

$tempDir = Join-Path ([IO.Path]::GetTempPath()) ("swavan-" + [guid]::NewGuid())
$installDir = if ($env:SWAVAN_INSTALL_DIR) { $env:SWAVAN_INSTALL_DIR } else { Join-Path $env:LOCALAPPDATA "Swavan\bin" }
New-Item -ItemType Directory -Force $tempDir, $installDir | Out-Null

try {
  $setup = Join-Path $tempDir "swavan-setup.exe"
  Invoke-WebRequest (Get-Asset '_x64-setup\.exe$') -OutFile $setup
  Start-Process $setup -ArgumentList "/S" -Wait

  $cliAsset = Find-Asset '^s3hs-windows-x86_64\.exe$'
  if ($cliAsset) {
    $cli = Join-Path $installDir "s3hs.exe"
    Invoke-WebRequest $cliAsset.browser_download_url -OutFile $cli
  } else {
    $searchRoots = @(
      (Join-Path $env:LOCALAPPDATA "Programs"),
      $env:ProgramFiles,
      ${env:ProgramFiles(x86)}
    ) | Where-Object { $_ -and (Test-Path $_) }
    $desktop = Get-ChildItem $searchRoots -Filter "swavan-ssh-studio.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $desktop) { throw "Desktop executable not found after installation." }
    $wrapper = Join-Path $installDir "s3hs.cmd"
    Set-Content $wrapper "@echo off`r`n`"$($desktop.FullName)`" cli %*" -Encoding ASCII
  }

  $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
  $parts = @($userPath -split ';' | Where-Object { $_ })
  if ($parts -notcontains $installDir) {
    [Environment]::SetEnvironmentVariable("Path", (($parts + $installDir) -join ';'), "User")
  }
  $env:Path = "$installDir;$env:Path"
  Write-Host "Installed Swavan SSH Studio and s3hs. Open a new terminal and run: s3hs --help"
} finally {
  Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
}

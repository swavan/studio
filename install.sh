#!/usr/bin/env sh
set -eu

repo="${SWAVAN_REPO:-swavan/studio}"
api="https://api.github.com/repos/${repo}/releases/latest"
install_dir="${SWAVAN_INSTALL_DIR:-$HOME/.local/bin}"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT INT TERM

command -v curl >/dev/null 2>&1 || { echo "curl is required." >&2; exit 1; }

release_json="$tmp_dir/release.json"
curl -fsSL "$api" -o "$release_json"
asset_url() {
  pattern="$1"
  sed -n 's/.*"browser_download_url": *"\([^"]*\)".*/\1/p' "$release_json" |
    tr -d '\r' | grep -E "$pattern" | head -n 1
}

os="$(uname -s)"
arch="$(uname -m)"
mkdir -p "$install_dir"
cli_path="$tmp_dir/s2s"

case "$os" in
  Darwin)
    dmg_url="$(asset_url '\.dmg$')"
    [ -n "$dmg_url" ] || { echo "No macOS installer found in the latest release." >&2; exit 1; }
    curl -fL "$dmg_url" -o "$tmp_dir/swavan.dmg"
    mount_dir="$tmp_dir/mount"
    mkdir -p "$mount_dir"
    hdiutil attach "$tmp_dir/swavan.dmg" -nobrowse -quiet -mountpoint "$mount_dir"
    app_path="$(find "$mount_dir" -maxdepth 1 -name '*.app' -print -quit)"
    [ -n "$app_path" ] || { hdiutil detach "$mount_dir" -quiet; echo "App bundle missing from DMG." >&2; exit 1; }
    if [ -w /Applications ]; then
      ditto "$app_path" "/Applications/Swavan Studio.app"
    else
      sudo ditto "$app_path" "/Applications/Swavan Studio.app"
    fi
    hdiutil detach "$mount_dir" -quiet
    cli_url="$(asset_url 's2s-macos-universal$' || true)"
    if [ -n "$cli_url" ]; then
      curl -fL "$cli_url" -o "$cli_path"
    else
      cp "/Applications/Swavan Studio.app/Contents/MacOS/s2s" "$cli_path"
    fi
    ;;
  Linux)
    [ "$arch" = "x86_64" ] || [ "$arch" = "amd64" ] || {
      echo "The Linux installer currently supports x86_64 only (detected $arch)." >&2
      exit 1
    }
    if command -v apt-get >/dev/null 2>&1 && command -v dpkg >/dev/null 2>&1; then
      app_url="$(asset_url '_amd64\.deb$')"
      curl -fL "$app_url" -o "$tmp_dir/swavan.deb"
      sudo apt-get install -y "$tmp_dir/swavan.deb"
      studio_bin="$(command -v swavan-ssh-studio || true)"
    elif command -v dnf >/dev/null 2>&1; then
      app_url="$(asset_url '\.x86_64\.rpm$')"
      curl -fL "$app_url" -o "$tmp_dir/swavan.rpm"
      sudo dnf install -y "$tmp_dir/swavan.rpm"
      studio_bin="$(command -v swavan-ssh-studio || true)"
    else
      app_url="$(asset_url '_amd64\.AppImage$')"
      app_dir="${SWAVAN_APP_DIR:-$HOME/.local/opt/swavan-ssh-studio}"
      mkdir -p "$app_dir" "$HOME/.local/share/applications"
      curl -fL "$app_url" -o "$app_dir/swavan-ssh-studio.AppImage"
      chmod +x "$app_dir/swavan-ssh-studio.AppImage"
      studio_bin="$app_dir/swavan-ssh-studio.AppImage"
      cat > "$HOME/.local/share/applications/swavan-ssh-studio.desktop" <<EOF
[Desktop Entry]
Name=Swavan Studio
Exec=$app_dir/swavan-ssh-studio.AppImage
Type=Application
Terminal=false
Categories=Development;Network;
EOF
    fi
    cli_url="$(asset_url 's2s-linux-x86_64$' || true)"
    if [ -n "$cli_url" ]; then
      curl -fL "$cli_url" -o "$cli_path"
    else
      [ -n "${studio_bin:-}" ] || {
        echo "Desktop executable not found after installation." >&2
        exit 1
      }
      cat > "$cli_path" <<EOF
#!/usr/bin/env sh
exec "$studio_bin" cli "\$@"
EOF
    fi
    ;;
  *)
    echo "Unsupported OS: $os. On Windows, use install.ps1 from PowerShell." >&2
    exit 1
    ;;
esac

chmod +x "$cli_path"
mv -f "$cli_path" "$install_dir/s2s"
rm -f "$install_dir/s3hs"
ln -s "s2s" "$install_dir/s3hs"

echo "Installed Swavan Studio and s2s (with s3hs compatibility alias)."
case ":$PATH:" in
  *":$install_dir:"*) ;;
  *) echo "Add $install_dir to PATH, then run: s2s --help" ;;
esac

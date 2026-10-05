# Swavan Studio

A cross-platform SSH connection manager, terminal, remote desktop client, and operations toolkit for developers and system administrators.

## Install

The installer detects the operating system and installs both the desktop app and the `s2s` CLI. The deprecated `s3hs` command remains available as a compatibility alias through version 0.2.13.

### macOS or Linux

```sh
curl -fsSL https://studio.swavan.io/install.sh | sh
```

### Windows PowerShell

```powershell
irm https://studio.swavan.io/install.ps1 | iex
```

Manual installers are available from [GitHub Releases](https://github.com/swavan/studio/releases/latest).

## Features

- SSH terminal with tabs, split panes, broadcast input, reconnection, and session recording
- Connection profiles with tags, OpenSSH config import, jump hosts, and host key verification
- Local, remote, and dynamic SOCKS SSH tunnels
- SFTP file browser, recursive transfers, and remote file editing
- Encrypted local vault, biometrics, multiple profiles, and encrypted export/import
- Script manager, command snippets, custom executors, and multi-server execution
- Server health monitoring for CPU, memory, disk, and network usage
- VNC and RDP remote desktop connections
- Saved database connections and desktop database workspace
- `s2s` desktop CLI for SSH, VNC, RDP, databases, snippets, and SSH agent workflows

## Platforms

The desktop app supports macOS, Windows, and Linux.

## Security

Credentials remain on the device and are encrypted at rest with ChaCha20-Poly1305 using an Argon2-derived key. The vault must be unlocked before protected connection data can be used.

## Health documentation

Read the [Health sources and dashboards guide](https://studio.swavan.io/health.html) to configure logs and metrics collection, query records, and save dashboard panels.

## CLI documentation

Read the [s2s CLI documentation](https://studio.swavan.io/docs.html) for installation, workflow examples, and the command reference captured from version 0.2.13.

© 2026 Swavan Studio

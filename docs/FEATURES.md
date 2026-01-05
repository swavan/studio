# SSH Studio - Feature List

SSH Studio is a comprehensive desktop SSH client application built with Tauri, React, and TypeScript. Below is a complete list of all features offered.

## 🔐 Core SSH Features

### SSH Connection Management
- **Create & Save Connections** - Store multiple SSH connection profiles
- **Connection Search** - Search connections by name, host, or username
- **Connection Pagination** - Browse connections with pagination controls
- **Connection Details** - View full connection information (host, port, username, etc.)
- **Edit Connections** - Modify existing connection profiles
- **Delete Connections** - Remove unwanted connections
- **Quick Access** - Recent connections accessible from dashboard

### Terminal & Session Management
- **Multiple Sessions** - Open and manage multiple SSH sessions simultaneously
- **Terminal Emulation** - Full xterm.js-based terminal with ANSI support
- **Session History** - View terminal session history
- **Session Tabs** - Organized tab-based session management
- **Terminal Resize** - Dynamic terminal resizing
- **Session Status** - View active session information
- **Disconnect Sessions** - Safely close SSH sessions

## 📁 File Management

### File Browser
- **Remote File Browsing** - Browse remote server directories
- **Multi-Tab Support** - Open multiple file browser tabs for different servers
- **File Listing** - Display files with detailed information:
  - File size
  - Modification date
  - Permissions
  - Owner/Group information
- **Directory Navigation** - Browse up/down directory tree
- **Home Directory** - Quick navigation to home directory
- **Path History** - Navigate through browsing history (back/forward)

### File Operations
- **Download Files** - Download remote files to local machine
- **Upload Files** - Upload local files to remote server
- **Rename Files** - Rename remote files and directories
- **Delete Files** - Delete remote files and directories
- **Delete Directories** - Remove directories with contents (recursive)
- **Create Directories** - Create new remote directories
- **Transfer Progress** - Real-time file transfer progress with speed indicator

### File Editor
- **Edit Remote Files** - Open and edit remote files directly in the app
- **Syntax Support** - Supports 50+ text file types:
  - Code files (JavaScript, TypeScript, Python, Rust, Go, Java, C++, etc.)
  - Configuration files (JSON, YAML, TOML, XML, .env, .conf)
  - Markup files (HTML, CSS, Markdown)
  - Shell scripts (Bash, Zsh, PowerShell)
  - Log files
  - And more...
- **File Size Limit** - 5MB maximum file size for editing
- **Cross-Platform** - Works on:
  - Windows servers (via PowerShell)
  - macOS servers
  - Linux servers
- **Auto-Detection** - Detects remote OS and uses appropriate write method
- **Direct Save** - Changes save directly to remote server
- **Unsaved Changes Warning** - Warns before closing with unsaved edits
- **File Type Detection** - Warns when editing non-text files
- **Fullscreen Editor** - Editor uses full screen for maximum workspace
- **Line/Character Count** - Shows content statistics

## 🌐 Network & Tunneling

### SSH Tunnels
- **Create Tunnels** - Establish local and remote port forwarding
- **Local Port Forwarding** - Forward local port to remote server and port
- **Remote Port Forwarding** - Forward remote port back to local machine
- **Tunnel Management** - Create, view, update, and delete tunnels
- **Tunnel Status** - Monitor active tunnels in real-time
- **Tunnel List** - View all configured tunnels with details
- **Auto-Tunnels** - Automatically start tunnels on connection
- **Port Configuration** - Configure local and remote ports
- **Tunnel Start/Stop** - Start and stop tunnels on demand
- **Tunnel Editing** - Modify existing tunnel configurations
- **Tunnel Deletion** - Remove unwanted tunnel configurations
- **Status Indicators** - Visual indicators for tunnel state (active/inactive)
- **Connection Association** - Link tunnels to specific SSH connections
- **Multiple Tunnels** - Support for multiple simultaneous tunnels per connection

### P2P Connections
- **Peer-to-Peer Networking** - Establish P2P connections between devices
- **Share Connection Profiles** - Securely share SSH connection profiles with other users
  - Option to share with or without credentials
  - Selective credential sharing for security
- **Peer Discovery** - Automatically discover other SSH Studio users on the network
- **Accept/Reject Shares** - Manual approval of incoming connection shares
- **Encrypted Transfer** - All P2P transfers are encrypted
- **Share Notifications** - Real-time notifications when peers discover you
- **Peer Management** - View discovered peers and their metadata
- **P2P Settings** - Enable/disable P2P sharing with a toggle
- **Capability Detection** - Automatically identify SSH Studio peers on network
- **Secure Credentials** - Received credentials are encrypted and stored in vault

## 🛡️ Security & Encryption

### Vault Management
- **Vault System** - Encrypted credential storage
- **Master Password** - Password-protected vault access
- **Vault Lock/Unlock** - Lock vault when not in use
- **Vault Security Settings** - Configure vault security options
- **Credential Encryption** - All credentials encrypted at rest
- **Password Change** - Change vault master password
- **Vault Initialization** - Set up vault on first use

## ⚙️ Settings & Customization

### Terminal Preferences
- **Font Selection** - Choose from 8 fonts:
  - JetBrains Mono
  - Fira Code
  - Menlo
  - Monaco
  - Source Code Pro
  - Inconsolata
  - Ubuntu Mono
  - Hack
- **Font Size** - Adjustable from 10px to 64px
- **Text Color** - Separate colors for light and dark modes
- **Selection Color** - Highlight color for text selection
- **Cursor Color** - Customize cursor appearance
- **Theme-Aware Colors** - Automatically switches colors based on light/dark mode
- **Reset to Defaults** - Restore default terminal preferences

### Appearance
- **Light/Dark Mode** - Toggle between light and dark themes
- **System Theme Detection** - Auto-detect system theme preference
- **Theme Persistence** - Save theme preference

### Application Settings
- **General Settings** - App-wide configuration
- **System Information** - View app version and system info
- **App Data Location** - Display where app stores data
- **Storage Information** - View app data directory path
- **Copy Path** - Copy app data path to clipboard
- **Open Folder** - Open app data folder in file explorer (desktop only)

## 📦 Data Storage

### Local Storage
- **Connection Profiles** - Securely stored SSH connection details
- **Terminal Preferences** - Saved terminal customization settings
- **File Browser State** - Remembered file browser tabs and location
- **Settings State** - Preserved user preferences

### App Data Management
- **App Data Directory** - Centralized location for all app data
- **Encrypted Storage** - Credentials stored encrypted
- **Cross-Platform Storage** - Works on Windows, macOS, and Linux

## 🔄 Updates & Maintenance

### Update Management
- **Auto-Update Checks** - Check for application updates
- **Update Notifications** - Notify user of available updates
- **Manual Update** - Manually trigger update check
- **Update History** - View update information

## 🎨 UI/UX Features

### User Interface
- **Responsive Design** - Works on various screen sizes
- **Tabbed Interface** - Organize sessions and browsers in tabs
- **Dropdown Menus** - Context menus for quick actions
- **Dialog Windows** - Modal dialogs for confirmations and inputs
- **Search/Filter** - Search functionality across connections and files
- **Status Indicators** - Visual indicators for connection status
- **Loading States** - Show loading indicators during operations
- **Error Messages** - Clear error notifications and messages
- **Success Feedback** - Confirmation of successful operations

### Navigation
- **Sidebar Navigation** - Quick access to main features
- **Breadcrumb Navigation** - Show current location/path
- **Quick Actions** - Fast access buttons for common tasks
- **Keyboard Shortcuts** - Support for keyboard navigation

## 🖥️ Platform Support

### Supported Operating Systems
- **macOS** - Full support (Intel & Apple Silicon)
- **Windows** - Full support
- **Linux** - Full support

### Supported Remote Servers
- **Linux** - Full support
- **macOS** - Full support
- **Windows** - Full support (via PowerShell/CMD)

## 🔧 Technical Features

### Performance
- **Efficient Rendering** - React-based optimized UI
- **Async Operations** - Non-blocking file transfers and commands
- **Session Pooling** - Reuse SSH sessions for efficiency
- **Memory Management** - Efficient handling of large file operations

### Reliability
- **Error Handling** - Comprehensive error handling and recovery
- **Retry Logic** - Automatic retry for failed operations
- **Connection Recovery** - Reconnect to lost sessions
- **Data Validation** - Input validation on all forms

### Security
- **SSH Encryption** - Industry-standard SSH encryption
- **Password Protection** - Vault master password protection
- **Credential Encryption** - All credentials encrypted
- **Secure Session Management** - Safe handling of active sessions
- **No Plaintext Storage** - Credentials never stored in plain text

## 📊 Additional Features

### Notifications
- **Toast Notifications** - Non-intrusive status messages
- **Operation Feedback** - Confirm successful actions
- **Error Alerts** - Alert on failures

### Preferences Persistence
- **Auto-Save Settings** - Automatically save user preferences
- **Restore State** - Restore previous state on app launch
- **Local Storage** - Browser-based storage for persistence

### Accessibility
- **Keyboard Navigation** - Navigate without mouse
- **Dialog Focus** - Proper focus management in modals
- **Button States** - Clear disabled/enabled states
- **Text Contrast** - Readable text in all themes

---

## 🚀 Getting Started

1. **Create Connection** - Add a new SSH connection profile
2. **Connect** - Click to connect to your server
3. **Browse Files** - Open the file browser to manage remote files
4. **Edit Files** - Click edit on any text file to modify it
5. **Manage Vault** - Set up vault for secure credential storage
6. **Customize** - Configure terminal preferences and appearance

### Version

**Swavan SSH Studio** - 0.1.0


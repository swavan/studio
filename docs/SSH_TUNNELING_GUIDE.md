# SSH Tunneling Guide - SSH Studio

Complete guide to understanding and using SSH tunneling in SSH Studio with all available options.

## Table of Contents
1. [What is SSH Tunneling?](#what-is-ssh-tunneling)
2. [Local Port Forwarding](#local-port-forwarding)
3. [Remote Port Forwarding](#remote-port-forwarding)
4. [Auto-Tunnels](#auto-tunnels)
5. [Managing Tunnels](#managing-tunnels)
6. [Use Cases](#use-cases)
7. [Best Practices](#best-practices)

---

## What is SSH Tunneling?

SSH tunneling (also called SSH port forwarding) creates a secure, encrypted tunnel through an SSH connection to forward network traffic. This allows you to:

- **Access services** that are restricted to the remote network
- **Secure communications** by encrypting traffic through the tunnel
- **Bypass firewalls** by routing through an SSH server
- **Connect to databases** on private networks securely

All data transmitted through the tunnel is encrypted, providing both security and privacy.

---

## Local Port Forwarding

### Overview
Local port forwarding allows your local machine to access services on the remote server or remote network.

**Traffic Flow:** `Local Machine → SSH Server → Remote Service`

```
Your Computer                SSH Server              Remote Network
[Port 3306] ←SSH Tunnel→ [Server] ←→ [Database at 192.168.1.100:3306]
```

### How It Works

1. You specify a **local port** on your machine (e.g., 3306)
2. SSH Studio opens a tunnel from that local port
3. All traffic sent to your local port is encrypted and forwarded through SSH
4. The SSH server forwards the traffic to a **remote destination** (e.g., `database.internal:3306`)
5. Responses come back through the same tunnel

### Creating a Local Port Forward in SSH Studio

**Via UI:**
1. Go to Settings → Tunnels (or Tunnel Manager)
2. Click "New Tunnel" or "Create Tunnel"
3. Select tunnel type: **Local Port Forwarding**
4. Configure:
   - **Local Port:** `3306` (the port on YOUR machine)
   - **Remote Host:** `192.168.1.100` or `database.internal` (where the service is)
   - **Remote Port:** `3306` (the port on remote side)
   - **Connection:** Select which SSH connection to use
5. Click Create
6. Toggle tunnel ON to activate

### Example: Connect to Remote Database

**Scenario:** Your company database is on a private network accessible only through an SSH bastion host.

**Configuration:**
- Local Port: `3306`
- Remote Host: `db.company.local`
- Remote Port: `3306`
- SSH Connection: `Bastion Host`

**Usage:**
```bash
# On your local machine, connect to the database
mysql -h 127.0.0.1 -u dbuser -p
# The connection routes through: 127.0.0.1:3306 → [SSH Tunnel] → db.company.local:3306
```

### Example: Web Server Access

**Scenario:** Access a web server on a private network.

**Configuration:**
- Local Port: `8080`
- Remote Host: `webserver.internal`
- Remote Port: `80`
- SSH Connection: `Jump Server`

**Usage:**
```
Open browser → http://localhost:8080
# This routes to: webserver.internal:80 through the SSH tunnel
```

---

## Remote Port Forwarding

### Overview
Remote port forwarding allows remote services to access services on your local machine.

**Traffic Flow:** `Remote Machine → SSH Server → Local Service`

```
Remote Network             SSH Server              Your Computer
[Application] ←SSH Tunnel→ [Server] ←→ [Port 5000]
```

### How It Works

1. You specify a **remote port** on the SSH server (e.g., 8080)
2. Applications on the remote server connect to that port
3. Traffic is encrypted and sent back through the SSH tunnel
4. The tunnel forwards to your **local destination** (e.g., `localhost:5000`)
5. Your local service handles the request

### Creating a Remote Port Forward in SSH Studio

**Via UI:**
1. Go to Settings → Tunnels (or Tunnel Manager)
2. Click "New Tunnel" or "Create Tunnel"
3. Select tunnel type: **Remote Port Forwarding**
4. Configure:
   - **Remote Port:** `8080` (the port on SSH server)
   - **Local Host:** `127.0.0.1` or `localhost` (your machine)
   - **Local Port:** `5000` (your service port)
   - **Connection:** Select which SSH connection to use
5. Click Create
6. Toggle tunnel ON to activate

### Example: Share Local Development Server

**Scenario:** You're developing a web app locally and need to share it with a remote team member.

**Configuration:**
- Remote Port: `8080`
- Local Host: `127.0.0.1`
- Local Port: `3000` (your dev server)
- SSH Connection: `Development Server`

**Usage:**
```
Remote team member accesses: http://devserver.company.com:8080
# This routes to: 127.0.0.1:3000 (your local dev server)
```

### Example: Mobile App Testing

**Scenario:** Test your mobile app against a local API server.

**Configuration:**
- Remote Port: `5000`
- Local Host: `127.0.0.1`
- Local Port: `5000` (your API server)
- SSH Connection: `Testing Server`

**Usage:**
```
Mobile device connects to: 192.168.1.100:5000 (SSH server's IP)
# This routes to: your-machine:5000 (your API)
```

---

## Auto-Tunnels

### Overview
Auto-tunnels automatically start when you connect to an SSH server, eliminating the need to manually activate them each time.

### How Auto-Tunnels Work

1. When you connect to an SSH server
2. SSH Studio checks if any tunnels are configured for that connection
3. Any tunnel marked as "Auto" or "Auto-start" is automatically activated
4. The tunnel remains active while the SSH session is open
5. When you disconnect from SSH, the tunnel closes automatically

### Creating Auto-Tunnels in SSH Studio

**Via UI:**
1. Create a tunnel (Local or Remote Port Forwarding)
2. When creating or editing, check the option:
   - **✓ Auto-start tunnel** or **✓ Auto-Tunnel**
3. Save the tunnel configuration
4. Next time you connect to that SSH server, the tunnel starts automatically

### Example: Persistent Database Access

**Scenario:** Every time you connect to your production bastion host, you always need access to the database.

**Configuration:**
1. Create Local Port Forward:
   - Local Port: `3306`
   - Remote Host: `prod-db.internal`
   - Remote Port: `3306`
   - Connection: `Production Bastion`
   - ✓ Auto-start: Enabled

2. Now whenever you connect to "Production Bastion," the database tunnel starts automatically

**Benefit:** No need to manually start the tunnel every time you log in.

---

## Managing Tunnels

### View All Tunnels

**Via Tunnel Manager:**
1. Open SSH Studio
2. Navigate to Settings or Dashboard
3. Click "Tunnels" or "Tunnel Manager"
4. See all configured tunnels with:
   - Tunnel name/description
   - Type (Local or Remote)
   - Ports involved
   - Associated SSH connection
   - Current status (Active/Inactive)

### Start a Tunnel

**Method 1: Toggle in UI**
1. Open Tunnel Manager
2. Find the tunnel you want
3. Click the toggle/switch to turn it ON
4. Status changes to "Active" with visual indicator

**Method 2: Auto-start**
- If configured with auto-tunnel, starts automatically on connection

### Stop a Tunnel

1. Open Tunnel Manager
2. Find the active tunnel
3. Click the toggle/switch to turn it OFF
4. Status changes to "Inactive"
5. All connections through this tunnel are closed

### Edit a Tunnel

1. Open Tunnel Manager
2. Find the tunnel to modify
3. Click "Edit" or the configuration icon
4. Update settings:
   - Local/Remote port
   - Host information
   - Auto-start setting
   - Tunnel name/description
5. Click "Save" or "Update"

### Delete a Tunnel

1. Open Tunnel Manager
2. Find the tunnel to remove
3. Click "Delete" or the trash icon
4. Confirm deletion
5. Tunnel configuration is removed (tunnel closes if active)

### Tunnel Status Indicators

**Active Tunnel (Green/Blue):**
- ✓ Tunnel is running
- Connection is established
- Traffic is being forwarded
- Safe to use

**Inactive Tunnel (Gray):**
- ✗ Tunnel is not running
- No traffic is being forwarded
- Requires manual activation
- Can be toggled ON when needed

**Error/Failed (Red):**
- ✗ Tunnel encountered an error
- Check SSH connection is active
- Verify ports are not in use
- Check remote host is reachable

---

## Use Cases

### 1. Database Administration

**Problem:** Database is on a private network, unreachable from your machine.

**Solution:** Local port forward to database
```
Local Port: 3306 → Remote: db-server.internal:3306

# Then use any database client:
mysql -h 127.0.0.1 -u admin -p
```

### 2. Web Server Management

**Problem:** Web server is behind firewall, only SSH accessible.

**Solution:** Local port forward to web server
```
Local Port: 80 → Remote: web.internal:80

# Access via: http://localhost
```

### 3. Development & Testing

**Problem:** Need to test local app against production environment.

**Solution:** Remote port forward your development environment
```
Remote Port: 8000 → Local: 127.0.0.1:8000

# Remote developers can access: your-server:8000
```

### 4. Jump Host / Bastion Access

**Problem:** Multiple layers of networks require jumping through bastion hosts.

**Solution:** Create tunnels through each bastion
```
Chain: Local → Bastion1 → Bastion2 → Private Service
```

### 5. Monitoring & Metrics

**Problem:** Prometheus/Grafana on internal network not accessible.

**Solution:** Local port forward to monitoring dashboard
```
Local Port: 9090 → Remote: metrics.internal:9090

# Access: http://localhost:9090
```

### 6. Git Server Access

**Problem:** Internal Git server only accessible via SSH from bastion.

**Solution:** Local port forward to Git server
```
Local Port: 22 → Remote: git-server.internal:22

# Clone: git clone ssh://user@127.0.0.1/repo.git
```

### 7. File Transfer (SCP/SFTP)

**Problem:** Need SFTP access to internal server through bastion.

**Solution:** Local port forward to SFTP
```
Local Port: 2222 → Remote: file-server.internal:22

# SFTP: sftp -P 2222 user@127.0.0.1
```

### 8. VNC / Remote Desktop

**Problem:** VNC server on internal network.

**Solution:** Local port forward to VNC
```
Local Port: 5900 → Remote: desktop.internal:5900

# VNC client: Connect to 127.0.0.1:5900
```

---

## Best Practices

### Security

✅ **DO:**
- Use tunnels for accessing sensitive services (databases, admin panels)
- Keep SSH credentials secure in the Vault
- Use strong master passwords for vault
- Monitor active tunnels regularly
- Close unused tunnels
- Use auto-tunnels only for necessary services

❌ **DON'T:**
- Expose tunnel ports to the internet
- Use default/weak passwords
- Share tunnel connections casually
- Leave tunnels running 24/7 unnecessarily
- Forward to publicly accessible services

### Performance

✅ **DO:**
- Use specific port numbers, not low system ports (except for testing)
- Limit the number of active tunnels
- Close tunnels when not in use
- Monitor SSH connection stability

❌ **DON'T:**
- Keep too many simultaneous tunnels active
- Use bandwidth-heavy services through single tunnel
- Tunnel unnecessary traffic

### Organization

✅ **DO:**
- Name tunnels descriptively: `prod-db-forward`, `dev-app-share`
- Group related tunnels by connection
- Document which team members need which tunnels
- Use auto-start for frequently used tunnels
- Keep a list of common tunnel configurations

❌ **DON'T:**
- Create duplicate tunnels with different configurations
- Leave tunnels unnamed/undocumented
- Mix multiple purposes in one tunnel

### Troubleshooting

**Tunnel won't connect:**
1. Verify SSH connection is active
2. Check if remote host is reachable from SSH server
3. Verify remote port is listening
4. Check for port conflicts on local side
5. Review firewall rules on remote network

**Slow performance:**
1. Check SSH connection bandwidth
2. Verify no other heavy traffic on tunnel
3. Test remote service directly (without tunnel) for baseline
4. Check SSH server CPU/memory usage

**Port already in use:**
1. Check what's using the local port: `lsof -i :PORT`
2. Use a different local port
3. Stop conflicting service
4. Kill hanging tunnel process

---

## Quick Reference

### Local Port Forward Command Pattern
```
Local Port X ← SSH Tunnel → Remote Host:Remote Port Y
Access at: 127.0.0.1:X
```

### Remote Port Forward Command Pattern
```
Remote Port X ← SSH Tunnel → Local Host:Local Port Y
Access at: SSH-Server:X
```

### Common Tunnel Examples

| Use Case | Type | Local | Remote |
|----------|------|-------|--------|
| Database | Local | 3306 | db.internal:3306 |
| Web Server | Local | 8080 | web.internal:80 |
| API Server | Local | 3000 | api.internal:3000 |
| Share Dev App | Remote | 5000 | localhost:5000 |
| VNC Desktop | Local | 5900 | desktop.internal:5900 |
| Git Server | Local | 2222 | git.internal:22 |
| Monitoring | Local | 9090 | metrics.internal:9090 |

---

## Version

**SSH Studio Tunneling Guide** - Version 1.0

For more information, see [FEATURES.md](FEATURES.md)

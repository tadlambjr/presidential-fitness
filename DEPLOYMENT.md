# Presidential Fitness Test - Deployment Guide

This app uses **Kamal 2** for deployment to a Linode server with **Thruster** for TLS termination.

## Prerequisites

1. **Linode Server** with SSH access
2. **Domain name** pointed at your Linode IP
3. **GitHub account** with a Personal Access Token (PAT)
4. **Ruby 3.4+** and **Bundler** installed locally

## One-Time Setup

### 1. GitHub Container Registry Token

Create a GitHub Personal Access Token at https://github.com/settings/tokens:
- Scope: `write:packages`
- Keep this token safe — you'll need it for the next step

### 2. Configure Environment Variables

```bash
# Copy the example file
cp .env.example .env

# Edit .env and fill in:
# - KAMAL_REGISTRY_PASSWORD (your GitHub PAT)
# - RAILS_MASTER_KEY (from config/master.key)
```

### 3. Configure Kamal

Edit `config/deploy.yml` and replace the placeholders:
- `<your-github-username>` → your actual GitHub username
- `<your-linode-ip>` → your Linode server IP
- `<your-domain.com>` → your domain name

### 4. Add Kamal Secrets

```bash
# Add RAILS_MASTER_KEY to Kamal secrets
kamal secrets set RAILS_MASTER_KEY

# Add registry password to .env (already done in step 2)
```

## Deployment Commands

### First Deploy (Bootstrap)

```bash
# This installs Docker, Traefik, and your app on the server
kamal setup
```

### Subsequent Deploys

```bash
# Build, push, and deploy new version (zero-downtime)
kamal deploy

# Run migrations after deploy
kamal app exec 'rails db:migrate'
```

### Useful Commands

```bash
kamal app logs -f              # Tail app logs
kamal app exec 'bin/rails c'   # Rails console
kamal app reboot               # Restart the app
kamal rollback                 # Rollback to previous version
```

## Architecture

- **Kamal 2**: Manages Docker deployments with zero-downtime rolling updates
- **Thruster**: Embedded in the Rails Dockerfile, handles HTTP/2 and Let's Encrypt TLS
- **SQLite**: Database stored in `/var/lib/presidential-fitness/storage` on the server
- **GitHub Container Registry (ghcr.io)**: Stores Docker images

## Storage

The SQLite database and any uploaded files are stored in:
- Server path: `/var/lib/presidential-fitness/storage`
- Container path: `/rails/storage`

**Backup this directory regularly** to preserve your data.

## SSL/TLS

Thruster automatically obtains Let's Encrypt certificates for your domain. No manual SSL configuration needed.

## Troubleshooting

### Permission Denied on SSH
Ensure your SSH key is added to the Linode server's `~/.ssh/authorized_keys`.

### Registry Push Fails
Verify your GitHub PAT has the `write:packages` scope and is correctly set in `.env`.

### Database Not Found on First Deploy
Run `kamal app exec 'rails db:migrate'` after the first deploy to create the database.

## Server Requirements

- **RAM**: 1GB minimum (2GB recommended)
- **OS**: Ubuntu 22.04 LTS or similar
- **Docker**: Installed automatically by `kamal setup`

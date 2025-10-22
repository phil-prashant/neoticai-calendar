# Cal.com Troubleshooting Guide

This guide addresses common issues you might encounter while setting up and running Cal.com.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Environment Configuration Issues](#environment-configuration-issues)
- [Database Issues](#database-issues)
- [Port Conflicts](#port-conflicts)
- [Node.js Version Issues](#nodejs-version-issues)
- [Dependency Issues](#dependency-issues)
- [Docker Issues](#docker-issues)
- [Build Issues](#build-issues)
- [Runtime Errors](#runtime-errors)

---

## Installation Issues

### Problem: Git clone fails with "Permission denied"

**Error:**
```
Permission denied (publickey).
fatal: Could not read from remote repository.
```

**Solution:**
1. Ensure you're using HTTPS clone URL:
   ```bash
   git clone https://github.com/calcom/cal.com.git
   ```
2. If you prefer SSH, configure your SSH keys:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   # Add the key to your GitHub account
   ```

### Problem: Symlinks not preserved on Windows

**Error:**
```
warning: symbolic links not supported on this platform
```

**Solution:**
Use the symlink flag when cloning:
```bash
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
```

Or enable symlinks globally:
```bash
git config --global core.symlinks true
```

### Problem: Yarn is not installed

**Error:**
```
yarn: command not found
```

**Solution:**
Install Yarn globally:
```bash
npm install -g yarn
```

Or use corepack (Node.js 16.10+):
```bash
corepack enable
corepack prepare yarn@stable --activate
```

---

## Environment Configuration Issues

### Problem: Missing NEXTAUTH_SECRET

**Error:**
```
Error: Please provide NEXTAUTH_SECRET environment variable.
```

**Solution:**
Generate and add the secret to your `.env` file:
```bash
echo "NEXTAUTH_SECRET=$(openssl rand -base64 32)" >> .env
```

### Problem: OpenSSL not found on Windows

**Error:**
```
'openssl' is not recognized as an internal or external command
```

**Solution:**

**Option 1:** Install OpenSSL for Windows
- Download from: https://slproweb.com/products/Win32OpenSSL.html
- Add to PATH: `C:\Program Files\OpenSSL-Win64\bin`

**Option 2:** Use Git Bash (comes with Git for Windows)
```bash
# Open Git Bash and run:
openssl rand -base64 32
```

**Option 3:** Generate online
- Visit: https://generate-secret.vercel.app/32
- Copy the generated secret

### Problem: Invalid DATABASE_URL format

**Error:**
```
Error: Invalid `prisma.client.$connect()` invocation
```

**Solution:**
Update your `.env` file with correct PostgreSQL connection string:
```env
DATABASE_URL="postgresql://username:password@localhost:5432/calcom?schema=public"
```

For Docker setup:
```env
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/calcom?schema=public"
```

---

## Database Issues

### Problem: Database connection refused

**Error:**
```
Error: P1001: Can't reach database server at `localhost:5432`
```

**Solutions:**

**If using local PostgreSQL:**
```bash
# Check if PostgreSQL is running
# Linux/macOS:
sudo systemctl status postgresql
# OR
brew services list

# Windows:
# Check Services app for PostgreSQL

# Start PostgreSQL if not running
# Linux:
sudo systemctl start postgresql
# macOS:
brew services start postgresql
```

**If using Docker:**
```bash
# Start the database container
docker-compose up -d postgres
```

### Problem: Database schema out of sync

**Error:**
```
Error: Schema Sync failed
```

**Solution:**
```bash
# Push the schema to the database
yarn db:push

# Or reset the database (WARNING: deletes all data)
yarn db:reset
```

### Problem: Prisma Client not generated

**Error:**
```
Error: Cannot find module '@prisma/client'
```

**Solution:**
```bash
# Generate Prisma Client
yarn db:generate

# Or reinstall dependencies
rm -rf node_modules
yarn
```

---

## Port Conflicts

### Problem: Port 3000 already in use

**Error:**
```
Error: listen EADDRINUSE: address already in use :::3000
```

**Solutions:**

**Option 1:** Change the port in `.env`
```env
PORT=3001
```

**Option 2:** Kill the process using port 3000

**Linux/macOS:**
```bash
# Find the process
lsof -i :3000

# Kill the process (replace PID with actual process ID)
kill -9 PID
```

**Windows (PowerShell):**
```powershell
# Find the process
Get-Process -Id (Get-NetTCPConnection -LocalPort 3000).OwningProcess

# Kill the process (replace PID with actual process ID)
Stop-Process -Id PID -Force
```

**Windows (CMD):**
```cmd
# Find and kill the process
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

---

## Node.js Version Issues

### Problem: Node version mismatch

**Error:**
```
error <package>: The engine "node" is incompatible with this module
```

**Solution:**
Use nvm to install and use the correct version:
```bash
# Install nvm if not already installed
# For Linux/macOS:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# For Windows:
# Download from: https://github.com/coreybutler/nvm-windows/releases

# Install and use the correct Node version
nvm install
nvm use
```

### Problem: nvm not found after installation

**Solution:**

**Linux/macOS:**
Add to your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):
```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

Then reload:
```bash
source ~/.bashrc  # or ~/.zshrc
```

**Windows:**
Make sure nvm-windows is installed correctly and restart your terminal.

---

## Dependency Issues

### Problem: Yarn install fails with network errors

**Error:**
```
YN0001: Error: connect ETIMEDOUT
```

**Solutions:**

**Option 1:** Clear Yarn cache
```bash
yarn cache clean
yarn
```

**Option 2:** Use a different registry
```bash
# Use Yarn official registry
yarn config set registry https://registry.yarnpkg.com

# Or use npm registry
yarn config set registry https://registry.npmjs.org
```

**Option 3:** Increase network timeout
```bash
yarn config set network-timeout 600000
yarn
```

### Problem: Conflicting dependencies

**Error:**
```
YN0000: ┌ Resolution step
YN0002: │ <package> doesn't provide <peer-dependency>
```

**Solution:**
This is usually a warning, not an error. If it causes issues:
```bash
# Clear cache and reinstall
rm -rf node_modules .yarn/cache
yarn cache clean
yarn
```

### Problem: Out of memory during installation

**Error:**
```
FATAL ERROR: Ineffective mark-compacts near heap limit Allocation failed
```

**Solution:**
Increase Node.js memory limit:
```bash
# Linux/macOS
export NODE_OPTIONS="--max_old_space_size=4096"
yarn

# Windows (PowerShell)
$env:NODE_OPTIONS="--max_old_space_size=4096"
yarn
```

---

## Docker Issues

### Problem: Docker daemon not running

**Error:**
```
Cannot connect to the Docker daemon
```

**Solution:**
Start Docker Desktop (Windows/macOS) or Docker daemon (Linux):

**Linux:**
```bash
sudo systemctl start docker
```

**Windows/macOS:**
- Open Docker Desktop application
- Wait for it to fully start

### Problem: Docker compose command not found

**Error:**
```
docker-compose: command not found
```

**Solution:**

**Option 1:** Install docker-compose
```bash
# Linux
sudo apt-get install docker-compose

# macOS (if using Homebrew)
brew install docker-compose
```

**Option 2:** Use docker compose (without hyphen) - Docker Compose V2
```bash
docker compose up -d
docker compose down
```

### Problem: Permission denied accessing Docker

**Error:**
```
Got permission denied while trying to connect to the Docker daemon socket
```

**Solution (Linux):**
```bash
# Add your user to the docker group
sudo usermod -aG docker $USER

# Log out and log back in, or run:
newgrp docker

# Test:
docker ps
```

### Problem: Containers fail to start

**Solution:**
```bash
# Check container logs
docker-compose logs -f

# Restart containers
docker-compose restart

# Complete reset
docker-compose down -v
docker-compose up -d
```

---

## Build Issues

### Problem: Build fails with TypeScript errors

**Error:**
```
Type error: <error message>
```

**Solution:**
```bash
# Clean build cache
rm -rf .next

# Regenerate Prisma Client
yarn db:generate

# Try building again
yarn build
```

### Problem: Out of memory during build

**Error:**
```
JavaScript heap out of memory
```

**Solution:**
```bash
# Increase Node.js memory
export NODE_OPTIONS="--max_old_space_size=8192"
yarn build
```

---

## Runtime Errors

### Problem: "Module not found" errors

**Error:**
```
Error: Cannot find module '<module-name>'
```

**Solution:**
```bash
# Clean install
rm -rf node_modules .next
yarn
```

### Problem: Hot reload not working

**Solution:**

**Linux:** Increase file watcher limit
```bash
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

**Windows/macOS:** Restart the dev server
```bash
# Stop with Ctrl+C
# Start again
yarn dev
```

### Problem: Session/Authentication issues

**Error:**
```
Error: [next-auth]: `secret` must be provided
```

**Solution:**
Ensure these are set in `.env`:
```env
NEXTAUTH_SECRET=<your-generated-secret>
NEXTAUTH_URL=http://localhost:3000
```

---

## General Debugging Tips

### Enable Debug Logging

Add to your `.env`:
```env
DEBUG=*
LOG_LEVEL=debug
```

### Check System Requirements

```bash
# Check Node version
node --version  # Should be v18.x or later

# Check Yarn version
yarn --version

# Check available disk space
df -h  # Linux/macOS
wmic logicaldisk get size,freespace,caption  # Windows
```

### Clean Slate Setup

If all else fails, start fresh:
```bash
# Navigate out of the cal.com directory
cd ..

# Remove the directory
rm -rf cal.com

# Clone again
git clone https://github.com/calcom/cal.com.git
cd cal.com

# Fresh install
yarn
```

---

## Getting Help

If you're still stuck:

1. **Check official documentation:**
   - https://cal.com/docs

2. **Search existing issues:**
   - https://github.com/calcom/cal.com/issues

3. **Ask the community:**
   - Discord: https://cal.com/discord
   - GitHub Discussions: https://github.com/calcom/cal.com/discussions

4. **Create a detailed issue:**
   - Include error messages
   - Specify your OS and Node.js version
   - Describe steps to reproduce
   - Share relevant configuration (without secrets!)

---

## Quick Reference: Common Commands

```bash
# Complete reset
docker-compose down -v
rm -rf node_modules .next
yarn
yarn db:push
yarn dev

# Fresh database
yarn db:reset

# Clear all caches
yarn cache clean
rm -rf node_modules .yarn/cache
yarn

# Check environment
node --version
yarn --version
docker --version
```

---

**Remember:** Most issues can be resolved by clearing caches, reinstalling dependencies, or checking environment variables. Always ensure you're using the correct Node.js version! 🚀

# Troubleshooting Guide for Cal.com Setup

This guide helps you resolve common issues when setting up and running Cal.com.

## Table of Contents

- [Prerequisites Issues](#prerequisites-issues)
- [Clone & Installation Issues](#clone--installation-issues)
- [Environment Configuration Issues](#environment-configuration-issues)
- [Database Issues](#database-issues)
- [Port & Network Issues](#port--network-issues)
- [Docker Issues](#docker-issues)
- [Build & Runtime Issues](#build--runtime-issues)
- [Performance Issues](#performance-issues)

---

## Prerequisites Issues

### Node.js Version Mismatch

**Problem:** Wrong Node.js version installed

**Solution:**
```bash
# Check your current Node version
node --version

# Install nvm if not already installed
# macOS/Linux:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Windows:
# Download and install from: https://github.com/coreybutler/nvm-windows/releases

# Install correct Node version
nvm install 18
nvm use 18
```

### Yarn Not Installed

**Problem:** `yarn: command not found`

**Solution:**
```bash
# Install Yarn globally via npm
npm install -g yarn

# Verify installation
yarn --version
```

### OpenSSL Not Available

**Problem:** `openssl: command not found`

**Solution:**

**macOS:**
```bash
# OpenSSL should be pre-installed, if not:
brew install openssl
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install openssl
```

**Windows:**
- Download from: https://slproweb.com/products/Win32OpenSSL.html
- Or use Git Bash which includes OpenSSL

---

## Clone & Installation Issues

### Git Clone Fails

**Problem:** Permission denied or network issues

**Solution:**
```bash
# Use HTTPS instead of SSH
git clone https://github.com/calcom/cal.com.git

# If still fails, check your internet connection and firewall
```

### Symlinks Not Preserved on Windows

**Problem:** Some files not working correctly on Windows

**Solution:**
```bash
# Clone with symlinks enabled
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git

# Or enable globally
git config --global core.symlinks true
```

### Yarn Install Fails

**Problem:** Dependency installation errors

**Solution:**
```bash
# Clear Yarn cache
yarn cache clean

# Remove node_modules
rm -rf node_modules

# Try installing again
yarn install

# If still fails, try with --network-timeout
yarn install --network-timeout 100000
```

### EACCES Permission Errors

**Problem:** Permission denied when installing packages

**Solution:**
```bash
# Don't use sudo! Instead, fix npm permissions
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile

# Then reinstall
yarn install
```

---

## Environment Configuration Issues

### Missing .env File

**Problem:** Application won't start, missing environment variables

**Solution:**
```bash
# Create .env from example
cp .env.example .env

# Generate required keys
openssl rand -base64 32  # For NEXTAUTH_SECRET
openssl rand -base64 32  # For CALENDSO_ENCRYPTION_KEY

# Edit .env and add the keys
```

### Invalid Environment Variables

**Problem:** `Invalid environment variables` error

**Solution:**
1. Check `.env` file for syntax errors
2. Ensure no trailing spaces
3. Wrap values with special characters in quotes
4. Verify all required variables are set

```bash
# View required variables
grep -v '^#' .env.example | grep '='
```

### NEXTAUTH_SECRET or CALENDSO_ENCRYPTION_KEY Not Set

**Problem:** Authentication or encryption errors

**Solution:**
```bash
# Generate new keys
KEY1=$(openssl rand -base64 32)
KEY2=$(openssl rand -base64 32)

# Add to .env (replace YOUR_KEY_HERE)
echo "NEXTAUTH_SECRET=\"$KEY1\"" >> .env
echo "CALENDSO_ENCRYPTION_KEY=\"$KEY2\"" >> .env
```

---

## Database Issues

### Database Connection Failed

**Problem:** `Can't reach database server`

**Solution:**

**If using Docker:**
```bash
# Ensure Docker is running
docker ps

# Start database container
yarn dx
```

**If using local PostgreSQL:**
```bash
# Check if PostgreSQL is running
# macOS:
brew services list | grep postgresql

# Linux:
sudo systemctl status postgresql

# Start PostgreSQL if stopped
# macOS:
brew services start postgresql

# Linux:
sudo systemctl start postgresql
```

### Database URL Invalid

**Problem:** Connection string format error

**Solution:**
```bash
# Standard format:
# postgresql://USER:PASSWORD@HOST:PORT/DATABASE

# Example for local development:
DATABASE_URL="postgresql://postgres:@localhost:5450/calendso"

# Docker development:
DATABASE_URL="postgresql://postgres:@localhost:5450/calendso"
```

### Migration Errors

**Problem:** `Migration failed` or schema out of sync

**Solution:**
```bash
# Reset database (WARNING: Deletes all data)
yarn prisma migrate reset

# Or manually run migrations
yarn prisma migrate dev

# If still fails, try cleaning
rm -rf node_modules/.prisma
yarn prisma generate
```

### Prisma Client Not Generated

**Problem:** `Cannot find module '@prisma/client'`

**Solution:**
```bash
# Generate Prisma client
yarn prisma generate

# Reinstall dependencies if needed
rm -rf node_modules
yarn install
```

---

## Port & Network Issues

### Port 3000 Already in Use

**Problem:** `Port 3000 is already in use`

**Solution:**

**Unix/Linux/macOS:**
```bash
# Find process using port 3000
lsof -i :3000

# Kill the process
lsof -ti:3000 | xargs kill -9
```

**Windows:**
```cmd
# Find process
netstat -ano | findstr :3000

# Kill process (replace <PID> with actual ID)
taskkill /PID <PID> /F
```

**Alternative:** Use a different port
```bash
# Set custom port
PORT=3001 yarn dev
```

### Port 5432 (PostgreSQL) Already in Use

**Problem:** Database port conflict

**Solution:**
```bash
# Change port in .env
DATABASE_URL="postgresql://postgres:@localhost:5433/calendso"

# Update docker-compose.yml if using Docker
```

### Cannot Access localhost:3000

**Problem:** Server starts but page doesn't load

**Solution:**
1. Check firewall settings
2. Try `http://127.0.0.1:3000` instead
3. Check browser console for errors
4. Verify the server actually started (check terminal output)

---

## Docker Issues

### Docker Not Running

**Problem:** `Cannot connect to Docker daemon`

**Solution:**
```bash
# Start Docker
# macOS/Windows: Start Docker Desktop application

# Linux:
sudo systemctl start docker

# Verify Docker is running
docker ps
```

### Docker Compose Fails

**Problem:** Services won't start

**Solution:**
```bash
# Check Docker Compose version
docker-compose --version

# Stop and remove containers
docker-compose down -v

# Rebuild and start
docker-compose up --build

# View logs
docker-compose logs -f
```

### Container Exits Immediately

**Problem:** Container starts then stops

**Solution:**
```bash
# Check container logs
docker-compose logs [service-name]

# Common causes:
# 1. Port already in use - change port mapping
# 2. Environment variable missing - check .env
# 3. Volume permission issues - check file permissions
```

### Out of Disk Space

**Problem:** Docker build fails due to disk space

**Solution:**
```bash
# Clean up Docker
docker system prune -a

# Remove unused volumes
docker volume prune

# Check disk space
df -h
```

---

## Build & Runtime Issues

### Build Fails - TypeScript Errors

**Problem:** Type checking errors during build

**Solution:**
```bash
# Run type check to see errors
yarn type-check

# Common fixes:
# 1. Update dependencies
yarn upgrade

# 2. Clear cache
rm -rf .next
rm -rf node_modules/.cache

# 3. Regenerate types
yarn prisma generate
```

### Module Not Found Errors

**Problem:** `Cannot find module 'xyz'`

**Solution:**
```bash
# Clear node_modules and reinstall
rm -rf node_modules
yarn cache clean
yarn install

# If specific package, reinstall it
yarn add <package-name>
```

### Next.js Build Errors

**Problem:** Build or compilation errors

**Solution:**
```bash
# Clear Next.js cache
rm -rf .next

# Clear all caches
rm -rf .next node_modules/.cache

# Rebuild
yarn build
```

### Out of Memory Errors

**Problem:** `JavaScript heap out of memory`

**Solution:**
```bash
# Increase Node memory limit
export NODE_OPTIONS="--max-old-space-size=4096"
yarn build

# Or in package.json, update build script:
# "build": "NODE_OPTIONS='--max-old-space-size=4096' next build"
```

### Hot Reload Not Working

**Problem:** Changes not reflecting in browser

**Solution:**
1. Hard refresh browser (Ctrl+Shift+R or Cmd+Shift+R)
2. Clear browser cache
3. Restart development server
4. Check file watching limits (Linux):
```bash
# Increase file watch limit
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

---

## Performance Issues

### Slow Development Server

**Problem:** Dev server takes long to start or reload

**Solution:**
```bash
# 1. Clear caches
rm -rf .next node_modules/.cache
yarn cache clean

# 2. Disable unnecessary features in development
# Check next.config.js for optimizations

# 3. Use SWC instead of Babel (should be default in Next.js 12+)

# 4. Increase memory
NODE_OPTIONS="--max-old-space-size=4096" yarn dev
```

### High CPU Usage

**Problem:** Development server using too much CPU

**Solution:**
1. Close unused applications
2. Disable file watchers temporarily
3. Use production mode for testing: `yarn build && yarn start`
4. Check for infinite loops in your code

### Yarn Install Takes Forever

**Problem:** Dependencies installation is very slow

**Solution:**
```bash
# Use faster network
# Or use offline mirror if available

# Clean install
rm -rf node_modules yarn.lock
yarn install

# Use specific registry
yarn install --registry https://registry.npmjs.org/
```

---

## General Debugging Steps

### Complete Reset (Nuclear Option)

When everything else fails:

```bash
# 1. Stop all processes
pkill -f "node" # Unix/Linux/macOS
# Or manually close all Node processes

# 2. Remove everything
rm -rf node_modules
rm -rf .next
rm -rf .turbo
rm yarn.lock

# 3. Clear caches
yarn cache clean

# 4. Clear Docker (if used)
docker-compose down -v
docker system prune -a

# 5. Fresh install
yarn install

# 6. Reset database
yarn prisma migrate reset

# 7. Start fresh
yarn dev
```

### Check System Resources

```bash
# Check available memory
free -h  # Linux
top      # macOS/Linux

# Check disk space
df -h

# Check CPU usage
top
htop  # if installed
```

### Enable Verbose Logging

```bash
# Run with debug output
DEBUG=* yarn dev

# Or specific modules
DEBUG=prisma:* yarn dev
```

---

## Getting Help

If you still have issues:

1. **Check the logs carefully** - Error messages usually point to the problem
2. **Search GitHub Issues**: [Cal.com Issues](https://github.com/calcom/cal.com/issues)
3. **Community Support**:
   - Slack: [cal.com/slack](https://cal.com/slack)
   - Discord: [go.cal.com/discord](https://go.cal.com/discord)
4. **Documentation**: [cal.com/docs](https://cal.com/docs)

### When Asking for Help

Include:
- Operating System and version
- Node.js version (`node --version`)
- Yarn version (`yarn --version`)
- Error messages (full output)
- Steps to reproduce
- What you've already tried

---

## Common Error Messages

### "Cannot find module"
→ Run `yarn install` or check import paths

### "Port is already in use"
→ Kill process on that port or use different port

### "Database connection failed"
→ Check DATABASE_URL and ensure PostgreSQL is running

### "Invalid environment variables"
→ Check .env file for missing or malformed values

### "Prisma Client is not generated"
→ Run `yarn prisma generate`

### "Out of memory"
→ Increase Node memory limit

### "EACCES permission denied"
→ Don't use sudo, fix npm permissions

### "Network request failed"
→ Check internet connection and firewall

---

**Still having issues?** See the [full setup guide](./SETUP_GUIDE.md) or [command reference](./COMMANDS_REFERENCE.md).

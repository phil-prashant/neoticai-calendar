# Cal.com Troubleshooting Guide

This guide covers common issues you might encounter when setting up and running Cal.com, along with their solutions.

---

## Table of Contents

1. [Installation Issues](#installation-issues)
2. [Environment Configuration Issues](#environment-configuration-issues)
3. [Node.js and Dependency Issues](#nodejs-and-dependency-issues)
4. [Database Issues](#database-issues)
5. [Development Server Issues](#development-server-issues)
6. [Docker Issues](#docker-issues)
7. [Build and Production Issues](#build-and-production-issues)
8. [Performance Issues](#performance-issues)

---

## Installation Issues

### Issue: Git clone fails with "Permission denied"

**Solution:**
```bash
# Use HTTPS instead of SSH if you don't have SSH keys set up
git clone https://github.com/calcom/cal.com.git

# Or set up SSH keys:
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh
```

### Issue: Symlinks not working on Windows

**Solution:**
```bash
# Clone with symlink support enabled
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git

# If already cloned, enable symlinks and re-clone
git config --global core.symlinks true
```

### Issue: Yarn not found

**Solution:**
```bash
# Install Yarn globally
npm install -g yarn

# Verify installation
yarn --version
```

---

## Environment Configuration Issues

### Issue: Missing .env file errors

**Solution:**
```bash
# Create .env from example
cp .env.example .env

# Verify file exists
ls -la .env
```

### Issue: Invalid NEXTAUTH_SECRET or CALENDSO_ENCRYPTION_KEY

**Solution:**
```bash
# Generate new secure keys
openssl rand -base64 32

# Update .env file with the generated key
# Make sure each key is unique (generate twice)
```

### Issue: Database connection string errors

**Solution:**
```env
# Correct format for DATABASE_URL in .env:
DATABASE_URL="postgresql://username:password@localhost:5432/database_name"

# For Docker:
DATABASE_URL="postgresql://postgres:password@localhost:5432/calcom"
```

### Issue: Email service not configured

**Solution:**
```env
# Add email configuration to .env
EMAIL_FROM=noreply@yourdomain.com
EMAIL_SERVER_HOST=smtp.gmail.com
EMAIL_SERVER_PORT=587
EMAIL_SERVER_USER=your-email@gmail.com
EMAIL_SERVER_PASSWORD=your-app-password
```

---

## Node.js and Dependency Issues

### Issue: Wrong Node.js version

**Solution:**
```bash
# Check current version
node --version

# Install and use correct version with nvm
nvm install
nvm use

# Verify
nvm current
```

### Issue: "Cannot find module" errors

**Solution:**
```bash
# Clear cache and reinstall
yarn cache clean
rm -rf node_modules
yarn install
```

### Issue: Dependency conflicts

**Solution:**
```bash
# Remove lock file and reinstall
rm yarn.lock
yarn install

# Or use legacy peer deps
yarn install --legacy-peer-deps
```

### Issue: Out of memory errors during installation

**Solution:**
```bash
# Increase Node memory limit
export NODE_OPTIONS="--max-old-space-size=4096"
yarn install
```

### Issue: Turbo cache issues

**Solution:**
```bash
# Clear Turbo cache
yarn turbo run build --force

# Or delete cache directory
rm -rf .turbo
```

---

## Database Issues

### Issue: Database connection fails

**Solution:**
```bash
# Check if PostgreSQL is running
# macOS:
brew services list

# Linux:
sudo systemctl status postgresql

# Start if not running:
brew services start postgresql  # macOS
sudo systemctl start postgresql  # Linux
```

### Issue: Prisma migration errors

**Solution:**
```bash
# Reset database
yarn db-reset

# Run migrations manually
yarn db-migrate

# If still failing, try:
npx prisma migrate reset
npx prisma migrate deploy
```

### Issue: "Table does not exist" errors

**Solution:**
```bash
# Generate Prisma client
npx prisma generate

# Run migrations
yarn db-migrate

# Restart development server
yarn dev
```

### Issue: Database seed fails

**Solution:**
```bash
# Clear database and reseed
yarn db-reset

# Or seed manually
npx prisma db seed
```

---

## Development Server Issues

### Issue: Port 3000 already in use

**Solution:**
```bash
# Linux/macOS - Find and kill process
lsof -ti:3000 | xargs kill -9

# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Or use a different port
PORT=3001 yarn dev
```

### Issue: Development server crashes on startup

**Solution:**
```bash
# Check for errors in .env file
cat .env

# Verify all required environment variables are set
# Ensure database is running
# Check Node version
nvm use

# Clear Next.js cache
rm -rf .next
yarn dev
```

### Issue: Hot reload not working

**Solution:**
```bash
# Clear Next.js cache
rm -rf .next

# Restart development server
yarn dev

# If on Linux, increase file watcher limit
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

### Issue: "Module not found" after adding dependency

**Solution:**
```bash
# Restart development server
# Press Ctrl+C then:
yarn dev

# If still failing:
rm -rf .next
yarn dev
```

---

## Docker Issues

### Issue: Docker containers won't start

**Solution:**
```bash
# Check Docker is running
docker --version
docker ps

# Start Docker service
# macOS: Start Docker Desktop
# Linux:
sudo systemctl start docker

# Clean up and restart
docker-compose down
docker-compose up -d
```

### Issue: Port conflicts in Docker

**Solution:**
```bash
# Stop conflicting services
docker-compose down

# Find processes using ports
lsof -ti:3000 | xargs kill -9
lsof -ti:5432 | xargs kill -9

# Restart Docker
docker-compose up -d
```

### Issue: Database volume issues

**Solution:**
```bash
# Remove volumes and recreate
docker-compose down -v
docker-compose up -d

# Or reset specific volume
docker volume rm calcom_database_data
```

### Issue: Docker build fails

**Solution:**
```bash
# Clean Docker build cache
docker system prune -a

# Rebuild without cache
docker-compose build --no-cache

# Start containers
docker-compose up -d
```

---

## Build and Production Issues

### Issue: Build fails with TypeScript errors

**Solution:**
```bash
# Run type check to see all errors
yarn type-check

# Fix errors or temporarily disable strict checking
# (Not recommended for production)

# Clear cache and rebuild
rm -rf .next
yarn build
```

### Issue: Build succeeds but production server crashes

**Solution:**
```bash
# Check all environment variables are set
# Verify DATABASE_URL is correct for production

# Run database migrations
yarn db-migrate

# Start with detailed logs
NODE_ENV=production yarn start
```

### Issue: Static file generation errors

**Solution:**
```bash
# Clear Next.js cache
rm -rf .next
rm -rf out

# Rebuild
yarn build
```

---

## Performance Issues

### Issue: Slow build times

**Solution:**
```bash
# Enable Turbo cache
yarn turbo run build

# Increase Node memory
export NODE_OPTIONS="--max-old-space-size=8192"

# Use SWC compiler (should be default)
# Check next.config.js has swcMinify: true
```

### Issue: Slow page loads in development

**Solution:**
```bash
# This is normal in development mode
# Use production build for testing performance
yarn build
yarn start
```

### Issue: High memory usage

**Solution:**
```bash
# Increase Node memory limit
export NODE_OPTIONS="--max-old-space-size=4096"

# Clear caches
rm -rf .next
rm -rf .turbo
yarn cache clean

# Restart development server
yarn dev
```

---

## General Debugging Steps

When encountering any issue, try these steps in order:

1. **Check error messages carefully** - They often point to the exact issue
2. **Verify environment variables** - Ensure .env is properly configured
3. **Check Node version** - Use `nvm use` to ensure correct version
4. **Clear caches** - Remove `.next`, `.turbo`, `node_modules`
5. **Restart services** - Stop and restart development server/database
6. **Check logs** - Look in terminal output for clues
7. **Search existing issues** - Check [GitHub Issues](https://github.com/calcom/cal.com/issues)
8. **Ask for help** - Join the [Cal.com Discord](https://cal.com/discord)

---

## Getting Help

If you're still stuck after trying these solutions:

1. **Check the documentation**: https://cal.com/docs
2. **Search GitHub Issues**: https://github.com/calcom/cal.com/issues
3. **Join Discord**: https://cal.com/discord
4. **Create a new issue**: Provide:
   - Error messages
   - Steps to reproduce
   - Environment details (OS, Node version, etc.)
   - What you've already tried

---

## Useful Debug Commands

```bash
# Check Node version
node --version
nvm current

# Check installed packages
yarn list --depth=0

# Check running processes
ps aux | grep node

# Check ports in use
lsof -i -P -n | grep LISTEN

# Check environment variables (be careful with sensitive data)
printenv | grep -i cal

# Check database connection
psql -h localhost -U postgres -d calcom

# View Next.js info
yarn next info

# Check Prisma schema
npx prisma validate

# View Docker logs
docker-compose logs -f
```

---

**For more information**, see:
- [Setup Guide](SETUP_GUIDE.md)
- [Quick Reference](QUICK_REFERENCE.md)
- [Cal.com Documentation](https://cal.com/docs)

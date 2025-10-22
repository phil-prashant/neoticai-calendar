# Terminal Command Blocks for Cal.com Setup

This document provides all the terminal commands needed to set up Cal.com, organized by platform and use case.

## Table of Contents
- [Linux/macOS Commands](#linuxmacos-commands)
- [Windows PowerShell Commands](#windows-powershell-commands)
- [Windows Command Prompt Commands](#windows-command-prompt-commands)
- [Docker Commands](#docker-commands)
- [Advanced Configuration](#advanced-configuration)

---

## Linux/macOS Commands

### Complete Setup Sequence

```bash
# Step 1: Clone the repository
git clone https://github.com/calcom/cal.com.git

# Step 2: Navigate to the directory
cd cal.com

# Step 3: Install dependencies
yarn

# Step 4a: Copy environment file
cp .env.example .env

# Step 4b: Generate NEXTAUTH_SECRET and save it
echo "NEXTAUTH_SECRET=$(openssl rand -base64 32)" >> .env

# Step 4c: Generate CALENDSO_ENCRYPTION_KEY and save it
echo "CALENDSO_ENCRYPTION_KEY=$(openssl rand -base64 32)" >> .env

# Step 5: Install and use correct Node.js version
nvm install
nvm use

# Step 6: Start development server
yarn dev
```

### Individual Commands Explained

**Clone Repository:**
```bash
git clone https://github.com/calcom/cal.com.git
```
What it does: Downloads the Cal.com source code from GitHub.

**Navigate to Directory:**
```bash
cd cal.com
```
What it does: Changes your current directory to the cloned repository.

**Install Dependencies:**
```bash
yarn
```
What it does: Installs all npm packages required by the project.

**Copy Environment File:**
```bash
cp .env.example .env
```
What it does: Creates your local environment configuration file.

**Generate NEXTAUTH_SECRET:**
```bash
openssl rand -base64 32
```
What it does: Generates a random 32-character encryption key.

**Generate CALENDSO_ENCRYPTION_KEY:**
```bash
openssl rand -base64 32
```
What it does: Generates another random 32-character encryption key.

**Edit .env File:**
```bash
nano .env
# OR
vim .env
# OR
code .env  # If you have VS Code installed
```
What it does: Opens the .env file for editing.

**Install Node.js Version:**
```bash
nvm install
```
What it does: Installs the Node.js version specified in .nvmrc.

**Use Node.js Version:**
```bash
nvm use
```
What it does: Switches to the correct Node.js version.

**Start Development Server:**
```bash
yarn dev
```
What it does: Starts the local development server on port 3000.

**Start with Docker:**
```bash
yarn dx
```
What it does: Starts the application with all services in Docker containers.

---

## Windows PowerShell Commands

### Complete Setup Sequence

```powershell
# Step 1: Clone the repository (with symlink support)
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git

# Step 2: Navigate to the directory
cd cal.com

# Step 3: Install dependencies
yarn

# Step 4a: Copy environment file
Copy-Item .env.example .env

# Step 4b: Generate and add NEXTAUTH_SECRET
$nextAuthSecret = & openssl rand -base64 32
Add-Content -Path .env -Value "NEXTAUTH_SECRET=$nextAuthSecret"

# Step 4c: Generate and add CALENDSO_ENCRYPTION_KEY
$calendsoKey = & openssl rand -base64 32
Add-Content -Path .env -Value "CALENDSO_ENCRYPTION_KEY=$calendsoKey"

# Step 5: Install and use correct Node.js version
nvm install
nvm use

# Step 6: Start development server
yarn dev
```

### Alternative: Manual Key Generation

```powershell
# Generate keys and display them
Write-Host "NEXTAUTH_SECRET:"
openssl rand -base64 32

Write-Host "`nCALENDSO_ENCRYPTION_KEY:"
openssl rand -base64 32

# Then manually edit .env file
notepad .env
```

---

## Windows Command Prompt Commands

### Complete Setup Sequence

```cmd
REM Step 1: Clone the repository (with symlink support)
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git

REM Step 2: Navigate to the directory
cd cal.com

REM Step 3: Install dependencies
yarn

REM Step 4a: Copy environment file
copy .env.example .env

REM Step 4b & 4c: Generate keys (run these commands and copy the output)
openssl rand -base64 32
openssl rand -base64 32

REM Step 4d: Edit .env file manually
notepad .env

REM Step 5: Install and use correct Node.js version
nvm install
nvm use

REM Step 6: Start development server
yarn dev
```

---

## Docker Commands

### Starting Docker Development Environment

```bash
# Start all services in Docker
yarn dx

# Alternative: Using docker-compose directly
docker-compose up -d
```

### Managing Docker Containers

```bash
# View running containers
docker-compose ps

# View logs
docker-compose logs -f

# View logs for specific service
docker-compose logs -f web

# Stop all containers
docker-compose down

# Stop and remove volumes (complete cleanup)
docker-compose down -v

# Rebuild containers
docker-compose up -d --build

# Restart a specific service
docker-compose restart web
```

### Docker Troubleshooting

```bash
# Remove all stopped containers
docker container prune

# Remove all unused images
docker image prune -a

# Remove all unused volumes
docker volume prune

# Complete Docker cleanup
docker system prune -a --volumes
```

---

## Advanced Configuration

### Database Commands

```bash
# Push database schema
yarn db:push

# Generate Prisma client
yarn db:generate

# Seed database with sample data
yarn db:seed

# Reset database (WARNING: Deletes all data)
yarn db:reset

# View database in Prisma Studio
yarn db:studio
```

### Build Commands

```bash
# Build for production
yarn build

# Start production server (after build)
yarn start

# Build specific app
yarn workspace @calcom/web build
```

### Testing Commands

```bash
# Run all tests
yarn test

# Run tests in watch mode
yarn test:watch

# Run tests with coverage
yarn test:coverage

# Run E2E tests
yarn test:e2e
```

### Code Quality Commands

```bash
# Run linter
yarn lint

# Fix linting issues automatically
yarn lint:fix

# Format code with Prettier
yarn format

# Check formatting
yarn format:check

# Type check with TypeScript
yarn type-check
```

### Dependency Management

```bash
# Update all dependencies
yarn upgrade-interactive --latest

# Add a new dependency
yarn add <package-name>

# Add a dev dependency
yarn add -D <package-name>

# Remove a dependency
yarn remove <package-name>

# Clean install (removes node_modules and reinstalls)
rm -rf node_modules yarn.lock
yarn
```

---

## Stopping Services

### Stop Development Server

```bash
# In the terminal running yarn dev
Ctrl + C
```

### Stop Docker Services

```bash
# Stop containers but keep data
docker-compose down

# Stop containers and remove all data
docker-compose down -v
```

---

## Environment Variables Quick Setup

### Using Command Line (Linux/macOS)

```bash
# Create .env with required variables in one command
cat > .env << EOF
NEXTAUTH_SECRET=$(openssl rand -base64 32)
CALENDSO_ENCRYPTION_KEY=$(openssl rand -base64 32)
NEXTAUTH_URL=http://localhost:3000
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/calcom
EOF
```

### Using Command Line (Windows PowerShell)

```powershell
@"
NEXTAUTH_SECRET=$(openssl rand -base64 32)
CALENDSO_ENCRYPTION_KEY=$(openssl rand -base64 32)
NEXTAUTH_URL=http://localhost:3000
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/calcom
"@ | Out-File -FilePath .env -Encoding UTF8
```

---

## Automated Setup Scripts

### Run Bash Script (Linux/macOS)

```bash
# Download and run
curl -sSL https://raw.githubusercontent.com/phil-prashant/neoticai-calendar/main/setup-calcom.sh | bash

# Or run locally
chmod +x setup-calcom.sh
./setup-calcom.sh
```

### Run Batch Script (Windows)

```cmd
REM Download and run
curl -L -o setup-calcom.bat https://raw.githubusercontent.com/phil-prashant/neoticai-calendar/main/setup-calcom.bat
setup-calcom.bat

REM Or run locally
setup-calcom.bat
```

---

## Verification Commands

### Check Installation

```bash
# Check Node.js version
node --version

# Check npm version
npm --version

# Check Yarn version
yarn --version

# Check Git version
git --version

# Check nvm version
nvm --version

# Check Docker version
docker --version
docker-compose --version
```

### Check Application Status

```bash
# Check if server is running
curl http://localhost:3000

# Check if database is accessible
yarn db:studio

# Check environment variables
cat .env
```

---

## Summary Table

| Task | Linux/macOS | Windows (PowerShell) | Windows (CMD) |
|------|-------------|---------------------|---------------|
| Clone repo | `git clone https://github.com/calcom/cal.com.git` | `git clone -c core.symlinks=true https://github.com/calcom/cal.com.git` | Same as PowerShell |
| Copy .env | `cp .env.example .env` | `Copy-Item .env.example .env` | `copy .env.example .env` |
| Edit .env | `nano .env` or `vim .env` | `notepad .env` | `notepad .env` |
| Generate key | `openssl rand -base64 32` | `openssl rand -base64 32` | `openssl rand -base64 32` |
| Install deps | `yarn` | `yarn` | `yarn` |
| Start dev | `yarn dev` | `yarn dev` | `yarn dev` |
| Stop dev | `Ctrl + C` | `Ctrl + C` | `Ctrl + C` |

---

## Notes

- Always run commands from the `cal.com` directory after cloning
- Make sure to activate the correct Node.js version with `nvm use` before running yarn commands
- The development server typically runs on port 3000
- Check the official Cal.com documentation for the most up-to-date information

---

**Happy coding!** 🚀

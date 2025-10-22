# Cal.com Commands Reference

A comprehensive reference of all commands used in the Cal.com development workflow.

## Table of Contents

- [Setup Commands](#setup-commands)
- [Development Commands](#development-commands)
- [Database Commands](#database-commands)
- [Docker Commands](#docker-commands)
- [Code Quality Commands](#code-quality-commands)
- [Build & Deploy Commands](#build--deploy-commands)
- [Utility Commands](#utility-commands)

---

## Setup Commands

### Clone Repository

**Unix/Linux/macOS:**
```bash
git clone https://github.com/calcom/cal.com.git
```

**Windows (preserves symlinks):**
```bash
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
```

### Navigate to Directory
```bash
cd cal.com
```

### Install Dependencies
```bash
yarn install
# or simply
yarn
```

### Setup Environment
```bash
# Copy example environment file
cp .env.example .env

# Generate security keys (run twice for two different keys)
openssl rand -base64 32
```

### Node Version Management (with nvm)
```bash
# Install the specified Node.js version
nvm install

# Activate the specified Node.js version
nvm use

# Check current Node version
node --version
```

---

## Development Commands

### Start Development Server
```bash
yarn dev
```
- Starts Next.js development server at `http://localhost:3000`
- Watches for file changes
- Hot reloads the application

### Build for Production
```bash
yarn build
```
- Creates optimized production build
- Compiles TypeScript
- Bundles assets

### Start Production Server
```bash
yarn start
```
- Starts production server
- Requires `yarn build` to be run first

### Run Tests
```bash
# Run all tests
yarn test

# Run tests in watch mode
yarn test:watch

# Run tests with coverage
yarn test:coverage

# Run specific test file
yarn test path/to/test.spec.ts
```

### Run E2E Tests
```bash
# Run end-to-end tests
yarn test-e2e

# Run E2E tests in headed mode (with browser UI)
yarn test-e2e:headed
```

---

## Database Commands

### Prisma Migrations
```bash
# Create a new migration
yarn prisma migrate dev --name migration_name

# Apply pending migrations
yarn prisma migrate deploy

# Reset database (WARNING: Deletes all data)
yarn prisma migrate reset
```

### Prisma Studio (Database GUI)
```bash
# Open Prisma Studio
yarn prisma:studio
```
- Opens at `http://localhost:5555`
- Provides GUI for viewing/editing database

### Database Seeding
```bash
# Seed the database with sample data
yarn prisma:seed
```

### Generate Prisma Client
```bash
# Regenerate Prisma client
yarn prisma generate
```

### Database Schema
```bash
# Validate schema
yarn prisma validate

# Format schema file
yarn prisma format
```

---

## Docker Commands

### Start Docker Development Environment
```bash
yarn dx
```
- Starts all services (database, email, etc.)
- Starts development server
- Uses Docker Compose

### Stop Docker Containers
```bash
# Stop containers
yarn docker:stop

# Or using docker-compose directly
docker-compose down
```

### Clean Docker Environment
```bash
# Stop and remove containers and volumes
yarn docker:clean

# Or manually
docker-compose down -v
```

### View Docker Logs
```bash
# View logs for all services
docker-compose logs

# View logs for specific service
docker-compose logs web

# Follow logs in real-time
docker-compose logs -f
```

### Restart Docker Services
```bash
# Restart all services
docker-compose restart

# Restart specific service
docker-compose restart web
```

---

## Code Quality Commands

### Linting
```bash
# Run ESLint
yarn lint

# Fix auto-fixable issues
yarn lint:fix

# Lint specific files
yarn lint path/to/file.ts
```

### Type Checking
```bash
# Run TypeScript type checking
yarn type-check

# Type check in watch mode
yarn type-check:watch
```

### Code Formatting
```bash
# Format code with Prettier
yarn format

# Check formatting without modifying files
yarn format:check
```

### Run All Checks
```bash
# Run linting, type checking, and tests
yarn check-all
```

---

## Build & Deploy Commands

### Build Web Application
```bash
# Build main web app
yarn workspace @calcom/web build
```

### Build All Packages
```bash
# Build all workspace packages
yarn build
```

### Clean Build Artifacts
```bash
# Clean all build outputs
yarn clean

# Clean and reinstall dependencies
yarn clean:full
```

---

## Utility Commands

### Workspace Commands
```bash
# List all workspaces
yarn workspaces list

# Run command in specific workspace
yarn workspace @calcom/web [command]
```

### Dependency Management
```bash
# Add dependency to root
yarn add package-name

# Add dev dependency
yarn add -D package-name

# Add dependency to specific workspace
yarn workspace @calcom/web add package-name

# Remove dependency
yarn remove package-name

# Update dependencies
yarn upgrade
```

### Cache Management
```bash
# Clean Yarn cache
yarn cache clean

# Clean Next.js cache
rm -rf .next

# Clean all caches and dependencies
rm -rf node_modules .next
yarn cache clean
yarn install
```

### Git Commands
```bash
# Check status
git status

# View changes
git diff

# Create branch
git checkout -b feature-name

# Commit changes
git add .
git commit -m "commit message"

# Push changes
git push origin branch-name
```

---

## Troubleshooting Commands

### Kill Process on Port 3000

**Unix/Linux/macOS:**
```bash
# Find process using port 3000
lsof -ti:3000

# Kill process
lsof -ti:3000 | xargs kill -9
```

**Windows:**
```cmd
# Find process
netstat -ano | findstr :3000

# Kill process (replace <PID> with actual process ID)
taskkill /PID <PID> /F
```

### Clear All Caches
```bash
# Remove all build artifacts and caches
rm -rf node_modules .next .turbo
yarn cache clean
yarn install
```

### Reset Database
```bash
# WARNING: This will delete all data
yarn prisma migrate reset
```

### Check Environment
```bash
# Verify Node version
node --version

# Verify Yarn version
yarn --version

# Verify Git version
git --version

# Check if Docker is running
docker --version
docker-compose --version
```

---

## Environment-Specific Commands

### Development
```bash
NODE_ENV=development yarn dev
```

### Production
```bash
NODE_ENV=production yarn build
NODE_ENV=production yarn start
```

### Testing
```bash
NODE_ENV=test yarn test
```

---

## Quick Command Combinations

### Fresh Start (Clean Installation)
```bash
rm -rf node_modules .next
yarn cache clean
yarn install
yarn dev
```

### Quick Check (Before Committing)
```bash
yarn lint && yarn type-check && yarn test
```

### Full Reset (Nuclear Option)
```bash
yarn docker:clean
rm -rf node_modules .next .turbo
yarn cache clean
yarn install
yarn prisma migrate reset
yarn dev
```

---

## Keyboard Shortcuts

When development server is running:

- `Ctrl + C` - Stop the server
- `r` - Restart the server (in watch mode)
- `o` - Open browser (some setups)

---

## Additional Resources

For more detailed information, see:
- [SETUP_GUIDE.md](./SETUP_GUIDE.md) - Complete setup instructions
- [QUICK_START.md](./QUICK_START.md) - Quick start guide
- [Cal.com Documentation](https://cal.com/docs) - Official documentation

---

**💡 Tip:** Save this file for quick reference during development!

# Cal.com Quick Reference Cheat Sheet

## Installation Commands

### Clone Repository
```bash
# Linux/macOS
git clone https://github.com/calcom/cal.com.git

# Windows (with symlinks)
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
```

### Navigate to Directory
```bash
cd cal.com
```

### Install Dependencies
```bash
yarn
```

### Environment Setup
```bash
# Copy environment file
cp .env.example .env

# Generate keys (run twice for two different keys)
openssl rand -base64 32

# Edit .env and add:
# NEXTAUTH_SECRET=<first-key>
# CALENDSO_ENCRYPTION_KEY=<second-key>
```

### Node Version Management
```bash
nvm install  # Install Node version from .nvmrc
nvm use      # Use the installed version
```

### Start Development
```bash
yarn dev     # Standard development server
yarn dx      # Docker-based development
```

---

## Common Commands

| Command | Description |
|---------|-------------|
| `yarn dev` | Start development server at http://localhost:3000 |
| `yarn build` | Build the application for production |
| `yarn start` | Start production server |
| `yarn test` | Run test suites |
| `yarn lint` | Run ESLint to check code quality |
| `yarn format` | Format code with Prettier |
| `yarn type-check` | Run TypeScript type checking |
| `yarn db-migrate` | Run database migrations |
| `yarn db-seed` | Seed database with sample data |
| `yarn db-reset` | Reset database (drop and recreate) |
| `yarn dx` | Start development with Docker |

---

## Docker Commands

### Start Docker Environment
```bash
yarn dx
```

### Stop Docker Containers
```bash
docker-compose down
```

### Stop and Remove All Data
```bash
docker-compose down -v
```

### View Running Containers
```bash
docker ps
```

### View Logs
```bash
docker-compose logs -f
```

---

## Development Server Control

### Start Server
```bash
yarn dev
```

### Stop Server
- Press `Ctrl + C` in the terminal

### Kill Process on Port 3000 (if stuck)
```bash
# Linux/macOS
lsof -ti:3000 | xargs kill -9

# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

---

## Database Commands

### Run Migrations
```bash
yarn db-migrate
```

### Create Migration
```bash
yarn db-migrate:create
```

### Reset Database
```bash
yarn db-reset
```

### Seed Database
```bash
yarn db-seed
```

### Open Prisma Studio (Database GUI)
```bash
yarn db-studio
```

---

## Git Workflow

### Create New Branch
```bash
git checkout -b feature/your-feature-name
```

### Commit Changes
```bash
git add .
git commit -m "Your commit message"
```

### Push to Remote
```bash
git push origin your-branch-name
```

### Update from Main
```bash
git checkout main
git pull origin main
git checkout your-branch-name
git merge main
```

---

## Troubleshooting

### Clear Cache and Reinstall
```bash
yarn cache clean
rm -rf node_modules
rm yarn.lock
yarn install
```

### Reset Everything
```bash
# Stop all processes
# Then:
rm -rf node_modules
yarn install
yarn db-reset
yarn dev
```

### Check Node Version
```bash
node --version
nvm current
```

### Switch Node Version
```bash
nvm use
```

---

## Environment Variables

### Essential Variables
```env
# Authentication
NEXTAUTH_SECRET=<generated-secret>
NEXTAUTH_URL=http://localhost:3000

# Encryption
CALENDSO_ENCRYPTION_KEY=<generated-key>

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/calcom
```

### Generate Secrets
```bash
openssl rand -base64 32
```

---

## Project Structure

```
cal.com/
├── apps/
│   ├── web/           # Main Next.js application
│   └── api/           # API services
├── packages/
│   ├── ui/            # UI components
│   ├── lib/           # Shared libraries
│   ├── prisma/        # Database schema
│   ├── emails/        # Email templates
│   └── features/      # Feature modules
├── tests/
│   └── e2e/           # End-to-end tests
└── docs/              # Documentation
```

---

## URLs

| URL | Description |
|-----|-------------|
| `http://localhost:3000` | Main application |
| `http://localhost:3000/auth/login` | Login page |
| `http://localhost:3000/auth/signup` | Sign up page |
| `http://localhost:5555` | Prisma Studio (if running) |

---

## Useful Links

- **Documentation**: https://cal.com/docs
- **Repository**: https://github.com/calcom/cal.com
- **Contributing**: https://github.com/calcom/cal.com/blob/main/CONTRIBUTING.md
- **Discord**: https://cal.com/discord
- **Issues**: https://github.com/calcom/cal.com/issues

---

## Keyboard Shortcuts (in terminal)

| Shortcut | Action |
|----------|--------|
| `Ctrl + C` | Stop running process |
| `Ctrl + Z` | Suspend process |
| `Ctrl + L` | Clear terminal screen |
| `Ctrl + R` | Search command history |

---

## Package Management

### Add Dependency
```bash
yarn add <package-name>
```

### Add Dev Dependency
```bash
yarn add -D <package-name>
```

### Remove Dependency
```bash
yarn remove <package-name>
```

### Update Dependencies
```bash
yarn upgrade-interactive
```

---

## Testing

### Run All Tests
```bash
yarn test
```

### Run Tests in Watch Mode
```bash
yarn test:watch
```

### Run E2E Tests
```bash
yarn test:e2e
```

### Run Specific Test File
```bash
yarn test path/to/test-file
```

---

## Code Quality

### Lint Code
```bash
yarn lint
```

### Fix Linting Issues
```bash
yarn lint:fix
```

### Format Code
```bash
yarn format
```

### Type Check
```bash
yarn type-check
```

---

## Build & Deploy

### Build for Production
```bash
yarn build
```

### Start Production Server
```bash
yarn start
```

### Analyze Bundle Size
```bash
yarn analyze
```

---

**Quick Access**: For detailed instructions, see [SETUP_GUIDE.md](SETUP_GUIDE.md)

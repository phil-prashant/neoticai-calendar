# Cal.com Setup Process Flowchart

This document provides a visual representation of the Cal.com setup process.

## Setup Process Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                     START: Cal.com Setup                        │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 1: Prerequisites Check                                    │
│  ✓ Node.js installed?                                           │
│  ✓ Yarn installed?                                              │
│  ✓ Git installed?                                               │
│  ✓ OpenSSL installed?                                           │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 2: Clone Repository                                       │
│                                                                 │
│  Choose your OS:                                                │
│  ┌─────────────────────────┬─────────────────────────────────┐ │
│  │   Unix/Linux/macOS      │         Windows                 │ │
│  │  git clone <url>        │  git clone -c core.symlinks...  │ │
│  └─────────────────────────┴─────────────────────────────────┘ │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 3: Navigate to Directory                                  │
│  cd cal.com                                                     │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 4: Install Dependencies                                   │
│  yarn install                                                   │
│  (This may take several minutes)                                │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 5: Environment Configuration                              │
│                                                                 │
│  1. Copy .env.example to .env                                   │
│  2. Generate NEXTAUTH_SECRET (openssl rand -base64 32)         │
│  3. Generate CALENDSO_ENCRYPTION_KEY (openssl rand -base64 32) │
│  4. Update .env file with generated keys                        │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 6: Node Version Management (Optional)                     │
│                                                                 │
│  If using nvm:                                                  │
│  1. nvm install                                                 │
│  2. nvm use                                                     │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
                 ┌────────┴────────┐
                 │                 │
                 ▼                 ▼
    ┌────────────────┐   ┌────────────────┐
    │ Standard Setup │   │  Docker Setup  │
    │   yarn dev     │   │    yarn dx     │
    └────────┬───────┘   └────────┬───────┘
             │                    │
             └────────┬───────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  STEP 7: Access Application                                     │
│  Open browser: http://localhost:3000                            │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  SUCCESS! Cal.com is running                                    │
│  🎉 You can now:                                                │
│  • Create an account                                            │
│  • Set up event types                                           │
│  • Start scheduling                                             │
│  • Customize the application                                    │
└─────────────────────────────────────────────────────────────────┘
```

## Decision Tree: Which Setup Method?

```
                    Starting Setup
                          │
                          ▼
              ┌───────────────────────┐
              │  Do you want to use   │
              │  automation?          │
              └───────────┬───────────┘
                          │
             ┌────────────┴────────────┐
             │                         │
            YES                        NO
             │                         │
             ▼                         ▼
    ┌─────────────────┐      ┌─────────────────┐
    │ Choose Platform │      │  Follow Manual  │
    └────────┬────────┘      │  Instructions   │
             │               │  (SETUP_GUIDE)  │
    ┌────────┴────────┐      └─────────────────┘
    │                 │
    ▼                 ▼
┌─────────┐      ┌─────────┐
│  Unix/  │      │ Windows │
│  Linux  │      │         │
│  macOS  │      │         │
└────┬────┘      └────┬────┘
     │                │
     ▼                ▼
  setup.sh        setup.bat
```

## Development Workflow

```
┌─────────────────────────────────────────────────────────────────┐
│                    Daily Development Cycle                      │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  1. Start Development Server                                    │
│     yarn dev  or  yarn dx (Docker)                              │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  2. Make Code Changes                                           │
│     • Edit files                                                │
│     • Changes auto-reload                                       │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  3. Test Changes                                                │
│     • Manual testing in browser                                 │
│     • Run unit tests: yarn test                                 │
│     • Check types: yarn type-check                              │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  4. Database Changes (if needed)                                │
│     • Modify schema in packages/prisma/schema.prisma            │
│     • Run: yarn prisma migrate dev                              │
│     • View data: yarn prisma:studio                             │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  5. Code Quality Checks                                         │
│     • Lint: yarn lint                                           │
│     • Format: yarn format                                       │
│     • Type check: yarn type-check                               │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  6. Commit and Push                                             │
│     git add .                                                   │
│     git commit -m "message"                                     │
│     git push                                                    │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│  7. Stop Server (end of day)                                    │
│     Ctrl + C  or  yarn docker:stop                              │
└─────────────────────────────────────────────────────────────────┘
```

## Troubleshooting Decision Tree

```
                    Problem Occurred?
                          │
                          ▼
              ┌───────────────────────┐
              │  What's the issue?    │
              └───────────┬───────────┘
                          │
      ┌───────────────────┼───────────────────┐
      │                   │                   │
      ▼                   ▼                   ▼
┌──────────┐      ┌──────────────┐    ┌─────────────┐
│   Port   │      │  Database    │    │ Dependencies│
│ In Use   │      │   Issues     │    │   Issues    │
└─────┬────┘      └──────┬───────┘    └──────┬──────┘
      │                  │                    │
      ▼                  ▼                    ▼
Kill Process      Reset Database     Clean Reinstall
lsof -ti:3000    yarn prisma:reset   rm -rf node_modules
| xargs kill -9                        yarn cache clean
                                       yarn install
```

## Project Structure Overview

```
cal.com/
│
├── 📱 apps/
│   ├── web/           ← Main Next.js web application
│   ├── api/           ← API backend
│   └── console/       ← Admin console
│
├── 📦 packages/
│   ├── prisma/        ← Database (models, migrations)
│   ├── ui/            ← Shared UI components
│   ├── lib/           ← Utility functions
│   ├── features/      ← Feature modules
│   └── emails/        ← Email templates
│
├── 📚 libs/           ← Core shared libraries
│
├── 🐳 docker/         ← Docker configurations
│
├── ⚙️ Configuration Files
│   ├── .env           ← Environment variables
│   ├── package.json   ← Dependencies
│   ├── tsconfig.json  ← TypeScript config
│   └── .nvmrc         ← Node version
│
└── 📖 docs/           ← Documentation
```

## Key Files to Know

```
Important Files                        Purpose
═══════════════════════════════════════════════════════════════
.env                                   Environment configuration
.env.example                           Environment template
package.json                           Project dependencies
yarn.lock                              Dependency lock file
.nvmrc                                 Node version specification
tsconfig.json                          TypeScript configuration
docker-compose.yml                     Docker services config
packages/prisma/schema.prisma          Database schema
apps/web/pages/                        Next.js pages (routes)
apps/web/pages/api/                    API endpoints
```

## Quick Command Reference

```
Task                          Command
═══════════════════════════════════════════════════════════════
Start development            yarn dev
Start with Docker            yarn dx
Run tests                    yarn test
Check types                  yarn type-check
Lint code                    yarn lint
Format code                  yarn format
View database                yarn prisma:studio
Reset database               yarn prisma:reset
Build for production         yarn build
Stop Docker                  yarn docker:stop
Clean everything             rm -rf node_modules .next
                             yarn cache clean
                             yarn install
```

## Environment Setup Checklist

```
☐ Node.js installed (v18.x or later)
☐ Yarn installed (v1.22.0 or later)
☐ Git installed
☐ OpenSSL installed
☐ nvm installed (optional)
☐ Docker installed (optional)
☐ Repository cloned
☐ Dependencies installed (yarn)
☐ .env file created
☐ NEXTAUTH_SECRET generated and added
☐ CALENDSO_ENCRYPTION_KEY generated and added
☐ Development server started
☐ Application accessible at localhost:3000
```

---

For more detailed information, see:
- [SETUP_GUIDE.md](./SETUP_GUIDE.md) - Full setup instructions
- [QUICK_START.md](./QUICK_START.md) - Quick start guide
- [COMMANDS_REFERENCE.md](./COMMANDS_REFERENCE.md) - All commands

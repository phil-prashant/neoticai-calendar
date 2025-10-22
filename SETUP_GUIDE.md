# Cal.com Setup Guide

This guide will help you fully clone, configure, and run the Cal.com open-source scheduling infrastructure project from GitHub.

## Prerequisites

Before you begin, ensure you have the following installed:
- **Node.js** (version specified in `.nvmrc` file in Cal.com repo)
- **Yarn** package manager
- **Git**
- **nvm** (Node Version Manager) - recommended
- **OpenSSL** (for generating encryption keys)
- **Docker** (optional, for containerized development)

---

## Step 1: Clone the Cal.com Repository

### For Linux/macOS:
```bash
git clone https://github.com/calcom/cal.com.git
```

### For Windows:
Windows users need to preserve symlinks during cloning:
```bash
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
```

**What this does:** Downloads the complete Cal.com repository from GitHub to your local machine.

---

## Step 2: Navigate to the Repository

```bash
cd cal.com
```

**What this does:** Changes your current directory to the newly cloned Cal.com repository.

---

## Step 3: Install Dependencies

```bash
yarn
```

**What this does:** Installs all required Node.js dependencies defined in the `package.json` file using Yarn package manager. This may take several minutes depending on your internet connection.

---

## Step 4: Configure Environment Variables

### 4.1 Create .env file

```bash
cp .env.example .env
```

**What this does:** Creates a copy of the example environment configuration file that you'll customize with your own values.

### 4.2 Generate Encryption Keys

Generate two separate keys for NEXTAUTH_SECRET and CALENDSO_ENCRYPTION_KEY:

```bash
openssl rand -base64 32
```

Run this command **twice** to generate two different keys.

**What this does:** Generates cryptographically secure random strings (32 bytes, base64 encoded) for authentication and encryption purposes.

### 4.3 Update .env file

Edit the `.env` file and insert the generated keys:

```bash
# Open the .env file in your preferred editor
nano .env
# or
vim .env
# or
code .env  # if using VS Code
```

Find and update these lines with your generated keys:
```
NEXTAUTH_SECRET=<your-first-generated-key>
CALENDSO_ENCRYPTION_KEY=<your-second-generated-key>
```

**Important:** The `.env` file contains sensitive configuration. Never commit this file to version control.

---

## Step 5: Set Correct Node.js Version

```bash
nvm install
nvm use
```

**What this does:** 
- `nvm install`: Installs the Node.js version specified in the `.nvmrc` file in the Cal.com repository
- `nvm use`: Activates that specific Node.js version for your current terminal session

---

## Step 6: Initialize Development Environment

```bash
yarn dev
```

**What this does:** Starts the local development server with hot-reload enabled. The application will be available at `http://localhost:3000`.

**Note:** Keep this terminal window open while developing. The development server will continue running and automatically reload when you make code changes.

---

## Step 7: Access the Application

Open your web browser and navigate to:
```
http://localhost:3000
```

You should see the Cal.com application running locally!

---

## Alternative: Docker Development (Optional)

If you have Docker installed and prefer containerized development:

```bash
yarn dx
```

**What this does:** Starts the development environment using Docker containers. This includes the web application, database, and other required services all running in isolated containers.

**Advantages of Docker:**
- Consistent environment across different machines
- All dependencies containerized
- Easy cleanup and reset
- No need to install database servers locally

---

## Project Structure Overview

After setup, the Cal.com repository contains the following key folders:

```
cal.com/
├── apps/              # Main applications
│   ├── web/          # Primary Next.js web application
│   ├── api/          # API services
│   └── ...           # Other app modules
│
├── packages/          # Shared packages and libraries
│   ├── ui/           # Reusable UI components
│   ├── lib/          # Shared utility libraries
│   ├── prisma/       # Database schema and client
│   ├── emails/       # Email templates and utilities
│   ├── features/     # Feature modules
│   └── ...           # Other shared packages
│
├── libs/             # Core libraries
│   └── ...           # Shared library code
│
├── tests/            # Test suites
│   ├── e2e/          # End-to-end tests
│   └── ...           # Other test types
│
├── docs/             # Documentation
│
├── .env.example      # Environment variables template
├── package.json      # Root package configuration
├── turbo.json        # Turborepo configuration
└── yarn.lock         # Dependency lock file
```

### Key Folder Purposes:

- **`apps/`**: Contains all deployable applications. The main web app is in `apps/web/`.
- **`packages/`**: Shared code, components, and utilities used across different apps.
- **`libs/`**: Core library functions and utilities.
- **`tests/`**: Automated test suites for quality assurance.
- **`docs/`**: Project documentation and guides.

---

## Managing the Development Server

### Stop the Development Server

When running `yarn dev`:
- Press `Ctrl + C` in the terminal window where the server is running

### Stop Docker Containers

When running `yarn dx`:
```bash
# Stop all containers
docker-compose down

# Stop and remove all containers, networks, and volumes
docker-compose down -v
```

---

## Common Commands Reference

| Command | Purpose |
|---------|---------|
| `yarn` | Install dependencies |
| `yarn dev` | Start development server |
| `yarn build` | Build for production |
| `yarn start` | Start production server |
| `yarn test` | Run tests |
| `yarn lint` | Run linting |
| `yarn dx` | Start Docker development environment |
| `yarn db-migrate` | Run database migrations |
| `yarn db-seed` | Seed database with sample data |

---

## Troubleshooting

### Port 3000 Already in Use
If you get an error that port 3000 is already in use:
```bash
# Find and kill the process using port 3000
lsof -ti:3000 | xargs kill -9
# or on Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### Node Version Issues
If you encounter Node version errors:
```bash
# Ensure you're using the correct version
nvm use
# If that doesn't work, reinstall the correct version
nvm install
nvm use
```

### Dependency Issues
If you have dependency conflicts:
```bash
# Clear yarn cache and reinstall
yarn cache clean
rm -rf node_modules
yarn
```

### Database Issues
If you encounter database errors:
```bash
# Reset the database
yarn db-reset
# Run migrations
yarn db-migrate
```

---

## Next Steps

After successful setup:

1. **Create an account** - Visit `http://localhost:3000/auth/signup` to create your first user
2. **Explore the code** - Start with `apps/web/` to understand the main application
3. **Read the documentation** - Check the `docs/` folder for detailed guides
4. **Join the community** - Visit [Cal.com's GitHub Discussions](https://github.com/calcom/cal.com/discussions)

---

## Additional Resources

- **Official Documentation**: https://cal.com/docs
- **GitHub Repository**: https://github.com/calcom/cal.com
- **Contributing Guide**: https://github.com/calcom/cal.com/blob/main/CONTRIBUTING.md
- **Discord Community**: Join the Cal.com Discord for support and discussions

---

## Summary

This guide covered:
✅ Cloning the Cal.com repository  
✅ Installing dependencies with Yarn  
✅ Configuring environment variables  
✅ Setting up the correct Node.js version  
✅ Starting the development server  
✅ Alternative Docker-based setup  
✅ Understanding the project structure  
✅ Managing and stopping servers  

Happy coding! 🚀

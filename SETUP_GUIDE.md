# Cal.com Setup Guide

This comprehensive guide will help you clone, configure, and run the Cal.com open-source scheduling infrastructure project from GitHub.

## Prerequisites

Before you begin, ensure you have the following installed:
- **Node.js** (v18.x or later recommended)
- **Yarn** (v1.22.0 or later)
- **Git**
- **nvm** (Node Version Manager) - optional but recommended
- **Docker & Docker Compose** (optional, for containerized development)
- **OpenSSL** (for generating encryption keys)

---

## Step-by-Step Setup Instructions

### 1. Clone the Cal.com Repository

#### For Unix/Linux/macOS:
```bash
git clone https://github.com/calcom/cal.com.git
```

#### For Windows:
Windows users should include the symlinks flag to preserve symbolic links:
```bash
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
```

**What this does:** Downloads the entire Cal.com repository to your local machine.

---

### 2. Navigate into the Repository

```bash
cd cal.com
```

**What this does:** Changes your current directory to the newly cloned repository.

---

### 3. Install Dependencies

```bash
yarn
```

**What this does:** Installs all required Node.js dependencies defined in `package.json` and `yarn.lock`. This may take several minutes depending on your internet connection.

**Alternative:** If you don't have Yarn installed, you can install it first:
```bash
npm install -g yarn
```

---

### 4. Configure Environment Variables

#### Step 4a: Copy the Environment Example File

```bash
cp .env.example .env
```

**What this does:** Creates a new `.env` file from the provided example template.

#### Step 4b: Generate Security Keys

Generate two separate keys for `NEXTAUTH_SECRET` and `CALENDSO_ENCRYPTION_KEY`:

```bash
# Generate first key (for NEXTAUTH_SECRET)
openssl rand -base64 32

# Generate second key (for CALENDSO_ENCRYPTION_KEY)
openssl rand -base64 32
```

**What this does:** Creates cryptographically secure random strings (32 bytes encoded in base64) for authentication and encryption.

#### Step 4c: Update the .env File

Open the `.env` file in your text editor and update these values:

```env
# Find these lines and replace with your generated keys
NEXTAUTH_SECRET="<paste-first-generated-key-here>"
CALENDSO_ENCRYPTION_KEY="<paste-second-generated-key-here>"

# Database URL (default for local development)
DATABASE_URL="postgresql://postgres:@localhost:5450/calendso"

# Next Public Webapp URL
NEXT_PUBLIC_WEBAPP_URL="http://localhost:3000"
```

**Important:** Save the file after making these changes.

---

### 5. Ensure Correct Node.js Version

If you have `nvm` installed, use it to ensure you're using the correct Node.js version:

```bash
# Install the Node version specified in .nvmrc
nvm install

# Activate the correct Node version
nvm use
```

**What this does:** Reads the `.nvmrc` file in the repository and installs/activates the recommended Node.js version for Cal.com.

**Alternative (without nvm):** Check the `.nvmrc` file to see which Node.js version is required and ensure your system has that version or later installed.

---

### 6. Initialize the Local Development Environment

```bash
yarn dev
```

**What this does:** 
- Sets up the database schema (runs migrations)
- Starts the Next.js development server
- Watches for file changes and hot-reloads

The server will be available at `http://localhost:3000`

**Note:** The first run may take longer as it sets up the database and compiles the application.

---

### 7. Access the Application

Open your web browser and navigate to:

```
http://localhost:3000
```

You should see the Cal.com homepage. You can now create an account and start exploring the application.

---

## Docker-Based Development (Alternative)

If you prefer containerized development and have Docker installed, you can use the following approach:

### Step 1: Ensure Docker is Running

Make sure Docker Desktop (or Docker daemon) is running on your system.

### Step 2: Start Docker Development Environment

```bash
yarn dx
```

**What this does:** 
- Starts all necessary services (database, email server, etc.) using Docker Compose
- Sets up the development environment
- Starts the Next.js development server

The application will be available at `http://localhost:3000`

**Benefits of Docker approach:**
- Isolated environment
- Pre-configured services (PostgreSQL, Prisma Studio, etc.)
- Easier cleanup and reset

---

## Project Structure Overview

After cloning, you'll see the following key directories:

```
cal.com/
├── apps/              # Main applications
│   ├── web/          # Primary Next.js web application
│   ├── api/          # API routes and backend logic
│   └── console/      # Admin console
├── packages/         # Shared packages and libraries
│   ├── prisma/       # Database schema and migrations
│   ├── ui/           # Shared UI components
│   ├── lib/          # Utility libraries
│   ├── emails/       # Email templates
│   └── features/     # Feature-specific code
├── libs/             # Core libraries
├── docker/           # Docker configuration files
├── .github/          # GitHub Actions CI/CD workflows
├── public/           # Static assets
└── docs/             # Documentation
```

### Key Folder Purposes:

- **apps/web**: The main Cal.com web application (Next.js)
- **apps/api**: Backend API implementation
- **packages/prisma**: Database models, migrations, and Prisma client
- **packages/ui**: Reusable UI components shared across apps
- **packages/features**: Business logic organized by feature
- **packages/emails**: Email templates and email sending logic
- **libs**: Core shared libraries
- **docker**: Docker configuration for development and deployment

---

## Stopping the Development Server

### Standard Development Server (yarn dev)

Press `Ctrl + C` in the terminal where the server is running.

### Docker Development Environment (yarn dx)

To stop Docker containers:

```bash
# Stop all containers
yarn docker:stop

# Or manually stop containers
docker-compose down

# To stop and remove volumes (cleans database)
docker-compose down -v
```

---

## Useful Commands

### Development
```bash
yarn dev              # Start development server
yarn build            # Build for production
yarn start            # Start production server
yarn test             # Run tests
```

### Database
```bash
yarn prisma:migrate   # Run database migrations
yarn prisma:studio    # Open Prisma Studio (database GUI)
yarn prisma:seed      # Seed the database with sample data
```

### Docker
```bash
yarn dx               # Start Docker development environment
yarn docker:stop      # Stop Docker containers
yarn docker:clean     # Clean Docker containers and volumes
```

### Code Quality
```bash
yarn lint             # Run ESLint
yarn type-check       # Run TypeScript type checking
yarn format           # Format code with Prettier
```

---

## Troubleshooting

### Port Already in Use
If port 3000 is already in use:
```bash
# Find and kill the process using port 3000
# On Unix/Linux/macOS:
lsof -ti:3000 | xargs kill -9

# On Windows:
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### Database Connection Issues
- Ensure PostgreSQL is running (if not using Docker)
- Verify `DATABASE_URL` in `.env` is correct
- Try resetting the database: `yarn prisma:reset`

### Node Version Issues
- Ensure you're using the correct Node.js version
- Run `nvm use` if using nvm
- Check `.nvmrc` for the required version

### Missing Dependencies
```bash
# Clean install all dependencies
rm -rf node_modules
yarn cache clean
yarn install
```

### Docker Issues
```bash
# Restart Docker services
yarn docker:stop
yarn docker:clean
yarn dx
```

---

## Next Steps

1. **Explore the Documentation**: Check the `docs/` folder for detailed documentation
2. **Create Your First Event Type**: Log in and set up your scheduling preferences
3. **Customize**: Modify the code to fit your needs
4. **Contribute**: Check `CONTRIBUTING.md` for contribution guidelines
5. **Join the Community**: Visit [cal.com/slack](https://cal.com/slack) for support

---

## Additional Resources

- **Official Documentation**: [https://cal.com/docs](https://cal.com/docs)
- **GitHub Repository**: [https://github.com/calcom/cal.com](https://github.com/calcom/cal.com)
- **Community Slack**: [https://cal.com/slack](https://cal.com/slack)
- **Discord**: [https://go.cal.com/discord](https://go.cal.com/discord)

---

## Summary of Commands

Here's a quick reference of all commands in order:

```bash
# 1. Clone the repository
git clone https://github.com/calcom/cal.com.git
# For Windows: git clone -c core.symlinks=true https://github.com/calcom/cal.com.git

# 2. Navigate to directory
cd cal.com

# 3. Install dependencies
yarn

# 4. Configure environment
cp .env.example .env
openssl rand -base64 32  # Generate NEXTAUTH_SECRET
openssl rand -base64 32  # Generate CALENDSO_ENCRYPTION_KEY
# Edit .env file with generated keys

# 5. Set Node version (if using nvm)
nvm install
nvm use

# 6. Start development server
yarn dev

# 7. Access at http://localhost:3000

# Alternative: Docker development
# yarn dx
```

---

**Happy Coding! 🚀**

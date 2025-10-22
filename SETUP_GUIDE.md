# Cal.com Setup Guide

This guide provides step-by-step instructions to clone, configure, and run the Cal.com open-source scheduling infrastructure project.

## Prerequisites

Before you begin, ensure you have the following installed:
- Node.js (v18.x or later recommended)
- Yarn package manager
- Git
- nvm (Node Version Manager)
- OpenSSL (for generating encryption keys)
- Docker and Docker Compose (optional, for containerized development)

## Setup Instructions

### 1. Clone the Repository

For **Linux/macOS**:
```bash
git clone https://github.com/calcom/cal.com.git
```

For **Windows** (with symlink preservation):
```bash
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
```

**What this does:** Downloads the Cal.com source code from GitHub to your local machine. The `-c core.symlinks=true` flag on Windows ensures symbolic links are preserved correctly.

---

### 2. Navigate to the Repository

```bash
cd cal.com
```

**What this does:** Changes your current directory to the cloned Cal.com repository.

---

### 3. Install Dependencies

```bash
yarn
```

**What this does:** Installs all required Node.js packages and dependencies defined in the project's `package.json` file using Yarn.

---

### 4. Configure Environment Variables

#### Step 4a: Copy the example environment file

```bash
cp .env.example .env
```

**What this does:** Creates a `.env` file from the example template where you'll store sensitive configuration values.

#### Step 4b: Generate encryption keys

Run this command **twice** to generate two separate keys:

```bash
openssl rand -base64 32
```

**What this does:** Generates a random 32-character base64-encoded string suitable for use as an encryption key.

#### Step 4c: Update the .env file

Open the `.env` file in your text editor and update the following variables with the generated keys:

```bash
# Replace with the first generated key
NEXTAUTH_SECRET=<your-first-generated-key>

# Replace with the second generated key
CALENDSO_ENCRYPTION_KEY=<your-second-generated-key>
```

**Additional Configuration:** You may need to configure database connection strings and other services depending on your setup. Refer to the Cal.com documentation for complete `.env` configuration options.

---

### 5. Set the Correct Node.js Version

```bash
nvm install
nvm use
```

**What this does:** 
- `nvm install`: Reads the `.nvmrc` file in the repository (if present) and installs the specified Node.js version.
- `nvm use`: Activates the correct Node.js version for this project.

---

### 6. Initialize Local Development Environment

```bash
yarn dev
```

**What this does:** Starts the development server with hot-reloading enabled. This command typically:
- Sets up the database schema
- Runs database migrations
- Starts the Next.js development server
- Makes the application available at http://localhost:3000

---

### 7. Access the Application

Open your web browser and navigate to:

```
http://localhost:3000
```

You should see the Cal.com application running locally.

---

## Alternative: Docker-based Setup

If you have Docker and Docker Compose installed, you can use the containerized development environment:

```bash
yarn dx
```

**What this does:** 
- Starts all required services (database, mail server, etc.) in Docker containers
- Sets up the development environment automatically
- Provides a consistent development experience across different operating systems

---

## Project Structure Overview

After setup, the Cal.com repository contains the following key folders:

### Primary Folders

```
cal.com/
├── apps/           # Main applications
│   ├── web/        # The primary web application (Next.js)
│   ├── api/        # API routes and services
│   └── ...         # Other applications (mobile, desktop, etc.)
│
├── packages/       # Shared packages and libraries
│   ├── ui/         # Reusable UI components
│   ├── lib/        # Shared utility libraries
│   ├── prisma/     # Database schema and migrations
│   ├── emails/     # Email templates
│   └── ...         # Other shared packages
│
├── libs/           # Additional libraries and utilities
│
├── docs/           # Documentation
│
├── .env            # Environment configuration (created by you)
├── .env.example    # Example environment configuration
├── package.json    # Project dependencies and scripts
├── yarn.lock       # Locked dependency versions
└── turbo.json      # Turborepo configuration (monorepo management)
```

### Folder Purposes

- **apps/**: Contains standalone applications. The `web` folder houses the main Cal.com web application built with Next.js.
- **packages/**: Shared code that can be used across multiple apps. This promotes code reuse and consistency.
- **libs/**: Additional libraries and helper functions.
- **docs/**: Project documentation and guides.

---

## Stopping the Development Server

### For yarn dev

Press `Ctrl + C` in the terminal where the development server is running.

### For Docker (yarn dx)

To stop all Docker containers:

```bash
docker-compose down
```

Or, to stop and remove all containers, networks, and volumes:

```bash
docker-compose down -v
```

**What this does:** 
- Stops all running containers
- `-v` flag also removes associated volumes (database data, etc.)

---

## Common Issues and Troubleshooting

### Port Already in Use

If port 3000 is already in use, you can either:
1. Stop the service using port 3000
2. Change the port in your `.env` file by adding: `PORT=3001`

### Database Connection Issues

Ensure your database is running and the connection string in `.env` is correct. For Docker setup, the database should start automatically.

### Node Version Mismatch

Always use the Node.js version specified in `.nvmrc` by running `nvm use` before starting development.

---

## Next Steps

1. **Create an account**: Navigate to http://localhost:3000/signup to create your first user account.
2. **Explore the codebase**: Familiarize yourself with the project structure and key files.
3. **Read the documentation**: Check the `docs/` folder and [Cal.com's official documentation](https://cal.com/docs) for more detailed information.
4. **Start developing**: Make your changes and see them reflected immediately with hot-reloading.

---

## Additional Resources

- [Cal.com GitHub Repository](https://github.com/calcom/cal.com)
- [Cal.com Documentation](https://cal.com/docs)
- [Cal.com Contributing Guide](https://github.com/calcom/cal.com/blob/main/CONTRIBUTING.md)
- [Cal.com Community Discord](https://cal.com/discord)

---

## Summary of Key Commands

| Action | Command |
|--------|---------|
| Clone repository | `git clone https://github.com/calcom/cal.com.git` |
| Install dependencies | `yarn` |
| Copy environment file | `cp .env.example .env` |
| Generate encryption key | `openssl rand -base64 32` |
| Use correct Node version | `nvm install && nvm use` |
| Start development server | `yarn dev` |
| Start with Docker | `yarn dx` |
| Stop development server | `Ctrl + C` |
| Stop Docker containers | `docker-compose down` |

---

Happy coding! 🚀

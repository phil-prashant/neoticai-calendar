# Cal.com Setup & Configuration Guide

Welcome to the comprehensive setup guide for **Cal.com** - an open-source scheduling infrastructure project.

## 📋 Overview

This repository provides detailed instructions, scripts, and documentation to help you quickly clone, configure, and run the Cal.com project on your local machine.

## 🚀 Quick Start

### Option 1: Automated Setup (Recommended)

Use our automated setup script to configure everything in one go:

```bash
# Download and run the setup script
curl -sSL https://raw.githubusercontent.com/phil-prashant/neoticai-calendar/main/setup-calcom.sh | bash
```

Or if you've cloned this repository:

```bash
./setup-calcom.sh
```

### Option 2: Manual Setup

Follow the detailed step-by-step guide in [SETUP_GUIDE.md](./SETUP_GUIDE.md).

## 📚 Documentation

### Setup Guides
- **[SETUP_GUIDE.md](./SETUP_GUIDE.md)** - Complete step-by-step manual setup instructions
- **[QUICK_REFERENCE.md](./QUICK_REFERENCE.md)** - Quick reference card for all commands
- **[COMMANDS.md](./COMMANDS.md)** - Detailed command reference for all platforms

### Setup Scripts
- **[setup-calcom.sh](./setup-calcom.sh)** - Automated setup script (Linux/macOS)
- **[setup-calcom.bat](./setup-calcom.bat)** - Automated setup script (Windows)

### Support Documentation
- **[TROUBLESHOOTING.md](./TROUBLESHOOTING.md)** - Solutions to common problems
- **[FAQ.md](./FAQ.md)** - Frequently asked questions

## ✅ Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v18.x or later)
- **Yarn** package manager
- **Git**
- **nvm** (Node Version Manager)
- **OpenSSL** (for generating encryption keys)
- **Docker & Docker Compose** (optional, for containerized development)

## 📖 What You'll Learn

This guide covers:

1. ✅ Cloning the Cal.com repository from GitHub
2. ✅ Installing project dependencies with Yarn
3. ✅ Configuring environment variables securely
4. ✅ Setting up the correct Node.js version
5. ✅ Running the development server
6. ✅ Using Docker for containerized development (optional)
7. ✅ Understanding the project structure
8. ✅ Troubleshooting common issues

## 🛠️ Key Commands Reference

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

## 🏗️ Cal.com Project Structure

```
cal.com/
├── apps/           # Main applications (web, API, etc.)
├── packages/       # Shared packages and libraries
├── libs/           # Additional libraries and utilities
├── docs/           # Documentation
└── .env           # Your environment configuration
```

For a detailed breakdown, see the [Project Structure section](./SETUP_GUIDE.md#project-structure-overview) in the setup guide.

## 🐳 Docker Support

Cal.com supports Docker-based development for a consistent environment:

```bash
# Start all services in Docker
yarn dx

# Stop Docker containers
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## 🔧 Troubleshooting

### Port Already in Use

Change the port in your `.env` file:
```
PORT=3001
```

### Database Connection Issues

Ensure your database is running and the connection string in `.env` is correct.

### Node Version Mismatch

Always use the specified Node.js version:
```bash
nvm use
```

For more troubleshooting tips, see the [Common Issues section](./SETUP_GUIDE.md#common-issues-and-troubleshooting) in the setup guide.

## 🌐 Additional Resources

- [Cal.com Official Website](https://cal.com)
- [Cal.com GitHub Repository](https://github.com/calcom/cal.com)
- [Cal.com Documentation](https://cal.com/docs)
- [Cal.com Contributing Guide](https://github.com/calcom/cal.com/blob/main/CONTRIBUTING.md)
- [Cal.com Community Discord](https://cal.com/discord)

## 🤝 Contributing

This guide is maintained to help developers get started with Cal.com. If you find any issues or have suggestions for improvements, please:

1. Open an issue
2. Submit a pull request
3. Share your feedback

## 📝 License

This guide is provided as-is for educational purposes. Cal.com itself is licensed under the AGPLv3 license. Please refer to the [Cal.com repository](https://github.com/calcom/cal.com) for licensing details.

## 💡 About Cal.com

Cal.com is an open-source scheduling infrastructure that helps you manage appointments, meetings, and events. It's a powerful alternative to proprietary scheduling tools, offering:

- 🔒 Self-hosting capabilities
- 🎨 Customizable branding
- 🔌 Extensive integrations
- 📅 Multiple calendar support
- 👥 Team scheduling features
- 🌍 International support

## 📞 Support

For support with Cal.com itself:
- Visit the [Cal.com Documentation](https://cal.com/docs)
- Join the [Cal.com Discord Community](https://cal.com/discord)
- Check the [GitHub Issues](https://github.com/calcom/cal.com/issues)

For issues with this setup guide:
- Open an issue in this repository

---

**Happy scheduling!** 📆 ✨

Made with ❤️ for the Cal.com community
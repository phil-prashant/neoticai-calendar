# neoticai-calendar

🗓️ **Complete Setup Guide for Cal.com Open-Source Scheduling Platform**

This repository contains comprehensive documentation and automation scripts to help you clone, configure, and run the [Cal.com](https://github.com/calcom/cal.com) open-source scheduling infrastructure project.

## 📚 Documentation

- **[📑 Documentation Index](./INDEX.md)** - Complete navigation guide to all docs
- **[Quick Start Guide](./QUICK_START.md)** - Get started in minutes with condensed instructions
- **[Full Setup Guide](./SETUP_GUIDE.md)** - Complete detailed documentation with explanations
- **[Commands Reference](./COMMANDS_REFERENCE.md)** - Comprehensive command cheat sheet
- **[Process Flowchart](./PROCESS_FLOWCHART.md)** - Visual guides and decision trees
- **[Troubleshooting Guide](./TROUBLESHOOTING.md)** - Solutions to common issues
- **[Automated Setup Scripts](#-automated-setup)** - One-click setup for your platform

## 🚀 Quick Start

### Option 1: Automated Setup (Recommended)

#### Unix/Linux/macOS:
```bash
./setup.sh
```

#### Windows:
```cmd
setup.bat
```

### Option 2: Manual Setup

```bash
# Clone Cal.com repository
git clone https://github.com/calcom/cal.com.git
cd cal.com

# Install dependencies
yarn

# Configure environment
cp .env.example .env
# Generate and add keys to .env (see full guide)

# Start development server
yarn dev
```

See [QUICK_START.md](./QUICK_START.md) for complete manual steps.

## 📖 What's Included

This repository provides:

1. **Comprehensive Documentation**
   - Step-by-step setup instructions
   - Platform-specific commands (Windows, macOS, Linux)
   - Docker-based development alternative
   - Project structure overview
   - Troubleshooting guide

2. **Automation Scripts**
   - `setup.sh` - Bash script for Unix/Linux/macOS
   - `setup.bat` - Batch script for Windows
   - Automatic dependency checking
   - Environment configuration
   - Key generation

3. **Quick Reference**
   - Common commands cheat sheet
   - Development workflow tips
   - Resource links

## 🛠️ Prerequisites

Before using these guides, ensure you have:

- **Node.js** (v18.x or later)
- **Yarn** package manager
- **Git**
- **OpenSSL** (for key generation)
- **nvm** (optional, recommended)
- **Docker** (optional, for containerized development)

## 📋 Setup Overview

The setup process covers:

1. ✅ Cloning the Cal.com repository
2. ✅ Installing dependencies with Yarn
3. ✅ Configuring environment variables
4. ✅ Generating security keys
5. ✅ Managing Node.js versions
6. ✅ Starting the development server
7. ✅ Docker-based alternative setup
8. ✅ Project structure overview
9. ✅ Troubleshooting common issues

## 🎯 What You'll Learn

By following these guides, you'll understand:

- How to clone and configure Cal.com
- Environment variable configuration
- Security key generation
- Development vs Docker workflows
- Project architecture and folder structure
- Common development commands
- How to troubleshoot issues

## 🔗 Resources

- **Cal.com Repository**: [github.com/calcom/cal.com](https://github.com/calcom/cal.com)
- **Official Documentation**: [cal.com/docs](https://cal.com/docs)
- **Community Slack**: [cal.com/slack](https://cal.com/slack)
- **Discord**: [go.cal.com/discord](https://go.cal.com/discord)

## 📝 File Structure

```
neoticai-calendar/
├── README.md              # This file - overview and links
├── INDEX.md               # Complete navigation guide to all documentation
├── QUICK_START.md         # Condensed quick start guide
├── SETUP_GUIDE.md         # Comprehensive setup documentation
├── COMMANDS_REFERENCE.md  # All commands reference
├── PROCESS_FLOWCHART.md   # Visual guides and flowcharts
├── TROUBLESHOOTING.md     # Solutions to common problems
├── setup.sh               # Automated setup script (Unix/Linux/macOS)
└── setup.bat              # Automated setup script (Windows)
```

## 🤝 Contributing

Found an issue or want to improve the guides? Feel free to:
- Open an issue
- Submit a pull request
- Suggest improvements

## 📄 License

This documentation repository is provided as-is for educational purposes. Cal.com itself is licensed under its own terms - see the [Cal.com repository](https://github.com/calcom/cal.com) for details.

---

**Ready to start?** Check out the [Quick Start Guide](./QUICK_START.md) or [Full Setup Guide](./SETUP_GUIDE.md)!
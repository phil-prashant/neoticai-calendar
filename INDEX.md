# Documentation Index

Welcome to the Neoticai Calendar - Cal.com Setup Helper documentation!

## 📚 Documentation Overview

This repository contains comprehensive documentation and tools to help you set up Cal.com. Choose your path:

### For First-Time Users

1. **Start Here**: [README.md](README.md)
   - Quick overview and introduction
   - Technology stack information
   - Quick command reference

2. **Detailed Setup**: [SETUP_GUIDE.md](SETUP_GUIDE.md)
   - Complete step-by-step installation guide
   - Platform-specific instructions (Linux/macOS/Windows)
   - Environment configuration
   - Project structure overview
   - All 9 steps covered in detail

3. **Quick Setup (Automated)**: [setup-calcom.sh](setup-calcom.sh)
   - One-command setup script
   - Automated environment configuration
   - Error checking and validation

### For Experienced Users

1. **Quick Reference**: [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
   - Command cheat sheet
   - Common operations
   - Docker commands
   - Database operations
   - Git workflow

### When You Need Help

1. **Troubleshooting**: [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
   - Common issues and solutions
   - Platform-specific problems
   - Database issues
   - Docker problems
   - Performance optimization

### For Contributors

1. **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
   - How to contribute
   - Documentation standards
   - Testing guidelines
   - Submission process

## 🚀 Quick Start Paths

### Path 1: Manual Setup (Learning)
Perfect if you want to understand each step:
1. Read [SETUP_GUIDE.md](SETUP_GUIDE.md)
2. Follow steps 1-9 manually
3. Keep [QUICK_REFERENCE.md](QUICK_REFERENCE.md) handy

### Path 2: Automated Setup (Fast)
Perfect if you just want it working:
1. Download [setup-calcom.sh](setup-calcom.sh)
2. Run: `chmod +x setup-calcom.sh && ./setup-calcom.sh`
3. Done!

### Path 3: Docker Setup
Perfect if you prefer containerization:
1. Read Docker section in [SETUP_GUIDE.md](SETUP_GUIDE.md#alternative-docker-development-optional)
2. Run: `yarn dx`
3. Access at http://localhost:3000

## 📖 What Each File Contains

| File | Purpose | Size | Audience |
|------|---------|------|----------|
| [README.md](README.md) | Project overview, quick start | 2.7 KB | Everyone |
| [SETUP_GUIDE.md](SETUP_GUIDE.md) | Complete installation guide | 7.8 KB | Beginners |
| [QUICK_REFERENCE.md](QUICK_REFERENCE.md) | Command cheat sheet | 5.6 KB | Experienced |
| [TROUBLESHOOTING.md](TROUBLESHOOTING.md) | Problem solutions | 8.9 KB | When stuck |
| [setup-calcom.sh](setup-calcom.sh) | Automated setup script | 5.1 KB | Quick setup |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guide | 4.1 KB | Contributors |
| [LICENSE](LICENSE) | MIT License | 1.4 KB | Legal info |

## 🎯 By Use Case

### I want to...

**...get Cal.com running quickly**
→ Use [setup-calcom.sh](setup-calcom.sh)

**...learn how Cal.com works**
→ Read [SETUP_GUIDE.md](SETUP_GUIDE.md)

**...find a specific command**
→ Check [QUICK_REFERENCE.md](QUICK_REFERENCE.md)

**...fix an error**
→ See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

**...improve the documentation**
→ Read [CONTRIBUTING.md](CONTRIBUTING.md)

**...understand the project structure**
→ See [Project Structure](SETUP_GUIDE.md#project-structure-overview) in SETUP_GUIDE.md

## 🔗 External Resources

- **Cal.com Official Docs**: https://cal.com/docs
- **Cal.com Repository**: https://github.com/calcom/cal.com
- **Cal.com Contributing**: https://github.com/calcom/cal.com/blob/main/CONTRIBUTING.md
- **Cal.com Discord**: https://cal.com/discord

## 📋 Setup Steps at a Glance

1. **Clone**: `git clone https://github.com/calcom/cal.com.git`
2. **Navigate**: `cd cal.com`
3. **Install**: `yarn`
4. **Configure**: `cp .env.example .env` (then add keys)
5. **Node Version**: `nvm install && nvm use`
6. **Start**: `yarn dev`
7. **Access**: http://localhost:3000

## 🐳 Docker Quick Start

```bash
yarn dx
```

## 🛟 Getting Help

1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Search [Cal.com Issues](https://github.com/calcom/cal.com/issues)
3. Join [Cal.com Discord](https://cal.com/discord)
4. Create a new issue with details

## 📝 License

This documentation is licensed under the MIT License. See [LICENSE](LICENSE) for details.

Note: Cal.com itself has its own license. See https://github.com/calcom/cal.com/blob/main/LICENSE

---

**Choose your path above and get started! 🚀**

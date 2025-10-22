# Cal.com Setup Documentation Index

Welcome! This repository contains comprehensive documentation for setting up the Cal.com open-source scheduling infrastructure.

## 📖 Documentation Overview

This documentation is organized to help you get Cal.com up and running quickly, whether you prefer automated scripts or manual step-by-step instructions.

---

## 🎯 Quick Navigation

### For First-Time Users

1. **Start here:** [README.md](./README.md) - Overview and quick start
2. **Choose your path:**
   - **Automated:** Run [setup-calcom.sh](./setup-calcom.sh) (Linux/macOS) or [setup-calcom.bat](./setup-calcom.bat) (Windows)
   - **Manual:** Follow [SETUP_GUIDE.md](./SETUP_GUIDE.md)
3. **Need help?** Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

### For Reference

- **Quick commands:** [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)
- **Platform-specific commands:** [COMMANDS.md](./COMMANDS.md)
- **Common questions:** [FAQ.md](./FAQ.md)

---

## 📋 Document Descriptions

### Core Documentation

#### [README.md](./README.md)
**Purpose:** Main entry point and overview  
**Best for:** Getting started, understanding what's available  
**Contains:**
- Quick start options (automated vs. manual)
- Overview of all documentation
- Key commands reference table
- Project structure overview
- Links to all resources

---

### Setup Guides

#### [SETUP_GUIDE.md](./SETUP_GUIDE.md) ⭐ Most Comprehensive
**Purpose:** Complete step-by-step manual setup instructions  
**Best for:** First-time users who want to understand each step  
**Contains:**
- Detailed prerequisites
- Step-by-step clone, install, and configuration process
- Environment variable setup
- Node.js version management
- Docker alternative setup
- Project structure explanation
- Stopping services instructions

**Follow this if:** You want full control and understanding of the setup process.

---

#### [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) ⭐ For Quick Lookup
**Purpose:** Fast reference for all commands  
**Best for:** Users who know what they're doing and need a quick reminder  
**Contains:**
- All terminal commands in order
- One-liner setup chain
- Project structure at a glance
- Key Yarn scripts
- Common environment variables
- Troubleshooting quick fixes
- Development workflow
- Setup checklist

**Use this when:** You've done this before and just need the commands.

---

#### [COMMANDS.md](./COMMANDS.md) ⭐ Platform-Specific Details
**Purpose:** Detailed command reference for all platforms  
**Best for:** Finding the exact command for your OS and situation  
**Contains:**
- Linux/macOS commands
- Windows PowerShell commands
- Windows Command Prompt commands
- Docker commands
- Advanced configuration commands
- Database management commands
- Build and test commands
- Summary comparison table

**Use this when:** You need the specific syntax for your operating system.

---

### Setup Scripts

#### [setup-calcom.sh](./setup-calcom.sh) ⭐ Automated Setup (Linux/macOS)
**Purpose:** Automated setup script for Unix-like systems  
**Best for:** Quick automated setup on Linux or macOS  
**Features:**
- Checks all prerequisites
- Clones repository with appropriate settings
- Installs dependencies
- Generates and configures environment variables
- Sets up Node.js version
- Provides next steps

**Run with:**
```bash
./setup-calcom.sh
```

---

#### [setup-calcom.bat](./setup-calcom.bat) ⭐ Automated Setup (Windows)
**Purpose:** Automated setup script for Windows  
**Best for:** Quick automated setup on Windows  
**Features:**
- Checks all prerequisites (Git, Node, Yarn, OpenSSL)
- Clones repository with symlink support
- Installs dependencies
- Generates and configures environment variables
- Sets up Node.js version
- Provides next steps

**Run with:**
```cmd
setup-calcom.bat
```

---

### Support Documentation

#### [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) ⭐ Problem Solving
**Purpose:** Solutions to common problems  
**Best for:** When something goes wrong  
**Contains:**
- Installation issues
- Environment configuration issues
- Database problems
- Port conflicts
- Node.js version issues
- Dependency problems
- Docker issues
- Build and runtime errors
- General debugging tips

**Use this when:** You encounter an error or issue during setup or development.

---

#### [FAQ.md](./FAQ.md) ⭐ Common Questions
**Purpose:** Answers to frequently asked questions  
**Best for:** Understanding concepts and making decisions  
**Contains:**
- General questions about Cal.com
- Installation questions
- Environment configuration
- Node.js and dependencies
- Database questions
- Development workflow
- Docker questions
- Project structure
- Contributing
- Production deployment
- Security

**Use this when:** You have questions about why something is needed or how it works.

---

## 🛤️ Recommended Paths

### Path 1: Automated Setup (Fastest)
**Time:** ~20 minutes  
**Skill Level:** Beginner  

1. Read [README.md](./README.md)
2. Run appropriate setup script:
   - Linux/macOS: [setup-calcom.sh](./setup-calcom.sh)
   - Windows: [setup-calcom.bat](./setup-calcom.bat)
3. If issues arise, check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

---

### Path 2: Manual Setup (Most Educational)
**Time:** ~30 minutes  
**Skill Level:** Beginner to Intermediate  

1. Read [README.md](./README.md)
2. Follow [SETUP_GUIDE.md](./SETUP_GUIDE.md) step by step
3. Keep [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) open for commands
4. If issues arise, check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

---

### Path 3: Expert Quick Setup
**Time:** ~15 minutes  
**Skill Level:** Advanced  

1. Use [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)
2. Run the one-liner setup chain or individual commands
3. Reference [COMMANDS.md](./COMMANDS.md) for platform-specific needs

---

## 📊 Documentation Comparison

| Document | Length | Detail Level | Best For |
|----------|--------|--------------|----------|
| README.md | Short | Overview | Getting started |
| SETUP_GUIDE.md | Long | High | Learning & first-time setup |
| QUICK_REFERENCE.md | Medium | Medium | Quick lookup |
| COMMANDS.md | Long | High | Platform-specific commands |
| setup-calcom.sh | N/A | Automated | Linux/macOS automation |
| setup-calcom.bat | N/A | Automated | Windows automation |
| TROUBLESHOOTING.md | Long | High | Problem solving |
| FAQ.md | Long | Medium-High | Understanding concepts |

---

## 🔍 Finding What You Need

### I want to...

**...get started quickly**
→ [README.md](./README.md) → Run setup script

**...understand each step**
→ [SETUP_GUIDE.md](./SETUP_GUIDE.md)

**...find a specific command**
→ [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) or [COMMANDS.md](./COMMANDS.md)

**...fix an error**
→ [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

**...understand why something is needed**
→ [FAQ.md](./FAQ.md)

**...see all commands for my OS**
→ [COMMANDS.md](./COMMANDS.md)

**...automate the setup**
→ [setup-calcom.sh](./setup-calcom.sh) or [setup-calcom.bat](./setup-calcom.bat)

---

## 📚 Additional Resources

Beyond this repository:

- **Cal.com Official Documentation:** https://cal.com/docs
- **Cal.com GitHub Repository:** https://github.com/calcom/cal.com
- **Cal.com Discord Community:** https://cal.com/discord
- **Cal.com GitHub Discussions:** https://github.com/calcom/cal.com/discussions

---

## 🆘 Getting Help

1. **Search this documentation** - Use Ctrl+F or search in GitHub
2. **Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)** - Common issues and solutions
3. **Read [FAQ.md](./FAQ.md)** - Answers to common questions
4. **Search Cal.com Issues** - Someone may have had the same problem
5. **Ask on Discord** - The Cal.com community is helpful and active
6. **Create a GitHub Issue** - If you found a bug in these docs

---

## ✅ Checklist for Success

- [ ] Read [README.md](./README.md) overview
- [ ] Choose automated or manual setup
- [ ] Complete setup following chosen guide
- [ ] Verify server starts successfully at http://localhost:3000
- [ ] Bookmark [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) for future use
- [ ] Join [Cal.com Discord](https://cal.com/discord) for community support

---

## 📝 Documentation Maintenance

This documentation is maintained to help developers get started with Cal.com. If you find:
- Errors or outdated information
- Missing important details
- Confusing explanations
- Ways to improve

Please open an issue or submit a pull request!

---

**Happy scheduling!** 📅 ✨

*Last updated: October 2025*

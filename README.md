# Neoticai Calendar - Cal.com Setup Helper

This repository provides comprehensive documentation and resources for cloning, configuring, and running the [Cal.com](https://github.com/calcom/cal.com) open-source scheduling infrastructure project.

## 📚 Quick Start

For complete step-by-step instructions on setting up Cal.com, please see our detailed **[Setup Guide](SETUP_GUIDE.md)**.

**New here?** Check out our **[Documentation Index](INDEX.md)** for a guided tour of all available resources.

## 🚀 Quick Commands

```bash
# Clone Cal.com repository
git clone https://github.com/calcom/cal.com.git
cd cal.com

# Install dependencies
yarn

# Setup environment
cp .env.example .env
# Generate keys with: openssl rand -base64 32
# Add keys to .env file

# Use correct Node version
nvm install && nvm use

# Start development server
yarn dev

# Access at http://localhost:3000
```

## 📖 What's Included

- **[SETUP_GUIDE.md](SETUP_GUIDE.md)**: Complete setup instructions with:
  - Clone commands for all platforms (including Windows symlink configuration)
  - Dependency installation steps
  - Environment variable configuration
  - Node.js version management
  - Development server startup
  - Docker alternative setup
  - Project structure overview
  - Troubleshooting tips

## 🐳 Docker Alternative

For containerized development:
```bash
yarn dx
```

## 📂 Cal.com Project Structure

```
cal.com/
├── apps/              # Main applications (web, api, etc.)
├── packages/          # Shared packages and libraries
├── libs/             # Core libraries
├── tests/            # Test suites
└── docs/             # Documentation
```

See the [Setup Guide](SETUP_GUIDE.md) for detailed folder descriptions.

## 🛠️ Key Technologies

Cal.com is built with:
- **Next.js** - React framework for the web application
- **TypeScript** - Type-safe JavaScript
- **Prisma** - Database ORM
- **Tailwind CSS** - Utility-first CSS framework
- **tRPC** - End-to-end typesafe APIs
- **Turborepo** - High-performance build system

## 📚 Additional Resources

- [Cal.com Official Documentation](https://cal.com/docs)
- [Cal.com GitHub Repository](https://github.com/calcom/cal.com)
- [Contributing Guide](https://github.com/calcom/cal.com/blob/main/CONTRIBUTING.md)
- [Cal.com Community Discord](https://cal.com/discord)

## 🤝 Contributing

Contributions to improve this setup guide are welcome! Please feel free to submit issues or pull requests.

## 📄 License

This setup guide is provided as-is for helping developers get started with Cal.com. Please refer to the [Cal.com repository](https://github.com/calcom/cal.com) for the official project license.

---

**Need help?** Check out the detailed [Setup Guide](SETUP_GUIDE.md) for troubleshooting tips and additional information.
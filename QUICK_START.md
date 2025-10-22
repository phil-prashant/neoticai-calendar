# Quick Start Guide for Cal.com

This is a condensed version of the full setup guide. For detailed instructions, see [SETUP_GUIDE.md](./SETUP_GUIDE.md).

## Quick Setup (Manual)

```bash
# 1. Clone the repository
git clone https://github.com/calcom/cal.com.git
# Windows: git clone -c core.symlinks=true https://github.com/calcom/cal.com.git

# 2. Navigate to the directory
cd cal.com

# 3. Install dependencies
yarn

# 4. Setup environment variables
cp .env.example .env

# Generate keys (run twice, once for each variable)
openssl rand -base64 32

# Edit .env and add:
# - NEXTAUTH_SECRET="<first-key>"
# - CALENDSO_ENCRYPTION_KEY="<second-key>"

# 5. Use correct Node version (if using nvm)
nvm install && nvm use

# 6. Start development server
yarn dev

# 7. Open http://localhost:3000
```

## Quick Setup (Automated)

### Unix/Linux/macOS:
```bash
# Download and run the setup script
curl -O https://raw.githubusercontent.com/phil-prashant/neoticai-calendar/main/setup.sh
chmod +x setup.sh
./setup.sh
```

Or if you have this repository cloned:
```bash
./setup.sh
```

### Windows:
```cmd
REM Download and run the setup script
curl -O https://raw.githubusercontent.com/phil-prashant/neoticai-calendar/main/setup.bat
setup.bat
```

Or if you have this repository cloned:
```cmd
setup.bat
```

## Docker Alternative

```bash
# Start Docker development environment
yarn dx

# Access at http://localhost:3000
```

## Stop the Server

- **Standard**: Press `Ctrl + C`
- **Docker**: Run `yarn docker:stop` or `docker-compose down`

## Common Commands

```bash
yarn dev              # Start development server
yarn build            # Build for production
yarn test             # Run tests
yarn prisma:studio    # Open database GUI
yarn lint             # Run linter
```

## Project Structure

```
cal.com/
├── apps/              # Main applications (web, api, console)
├── packages/          # Shared packages (prisma, ui, features)
├── libs/              # Core libraries
├── docker/            # Docker configurations
└── docs/              # Documentation
```

## Troubleshooting

**Port in use:** Kill process on port 3000
```bash
# Unix/Linux/macOS
lsof -ti:3000 | xargs kill -9

# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

**Database issues:** Reset database
```bash
yarn prisma:reset
```

**Dependencies issues:** Clean reinstall
```bash
rm -rf node_modules
yarn cache clean
yarn install
```

## Resources

- 📖 [Full Setup Guide](./SETUP_GUIDE.md) - Complete detailed instructions
- 🌐 [Cal.com Documentation](https://cal.com/docs)
- 💬 [Community Slack](https://cal.com/slack)
- 🐛 [GitHub Issues](https://github.com/calcom/cal.com/issues)

---

**Need help?** See the [full setup guide](./SETUP_GUIDE.md) for detailed troubleshooting and explanations.

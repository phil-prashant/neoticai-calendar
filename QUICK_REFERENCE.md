# Cal.com Setup Quick Reference

## Terminal Commands for Complete Setup

### 1️⃣ Clone Repository

**Linux/macOS:**
```bash
git clone https://github.com/calcom/cal.com.git
```

**Windows:**
```bash
git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
```

---

### 2️⃣ Navigate to Repository

```bash
cd cal.com
```

---

### 3️⃣ Install Dependencies

```bash
yarn
```

---

### 4️⃣ Configure Environment

**Copy environment file:**
```bash
cp .env.example .env
```

**Generate NEXTAUTH_SECRET:**
```bash
openssl rand -base64 32
```

**Generate CALENDSO_ENCRYPTION_KEY:**
```bash
openssl rand -base64 32
```

**Edit .env file:**
```bash
# Open in your preferred editor
nano .env
# OR
vim .env
# OR
code .env
```

**Add the keys:**
```env
NEXTAUTH_SECRET=<paste-first-generated-key-here>
CALENDSO_ENCRYPTION_KEY=<paste-second-generated-key-here>
```

---

### 5️⃣ Setup Node Version

```bash
nvm install
nvm use
```

---

### 6️⃣ Start Development Server

**Standard development mode:**
```bash
yarn dev
```

**Docker-based development:**
```bash
yarn dx
```

---

### 7️⃣ Access Application

Open in browser:
```
http://localhost:3000
```

---

## Stopping the Server

### Stop yarn dev
```
Press: Ctrl + C
```

### Stop Docker
```bash
docker-compose down
```

### Stop Docker (with volume cleanup)
```bash
docker-compose down -v
```

---

## Complete Setup (One-Liner Chain)

For Linux/macOS, you can chain all commands:

```bash
git clone https://github.com/calcom/cal.com.git && \
cd cal.com && \
yarn && \
cp .env.example .env && \
echo "NEXTAUTH_SECRET=$(openssl rand -base64 32)" >> .env && \
echo "CALENDSO_ENCRYPTION_KEY=$(openssl rand -base64 32)" >> .env && \
nvm install && \
nvm use && \
echo "Setup complete! Run 'yarn dev' to start the development server."
```

**Note:** You'll still need to manually configure other `.env` variables as needed.

---

## Project Structure at a Glance

```
cal.com/
├── apps/
│   ├── web/              # Main Next.js web app
│   ├── api/              # API services
│   └── ...
├── packages/
│   ├── ui/               # UI components
│   ├── lib/              # Shared utilities
│   ├── prisma/           # Database schema
│   ├── emails/           # Email templates
│   └── ...
├── libs/                 # Additional libraries
├── docs/                 # Documentation
├── .env                  # Your config (created)
├── .env.example          # Example config
├── package.json          # Dependencies
├── yarn.lock             # Locked versions
└── turbo.json           # Monorepo config
```

---

## Key Yarn Scripts

```bash
yarn dev              # Start development server
yarn build            # Build for production
yarn start            # Start production server
yarn test             # Run tests
yarn lint             # Run linter
yarn format           # Format code
yarn dx               # Docker development mode
yarn db:push          # Push database schema
yarn db:seed          # Seed database
```

---

## Environment Variables (Important Ones)

```env
# Authentication
NEXTAUTH_SECRET=<your-secret>
NEXTAUTH_URL=http://localhost:3000

# Encryption
CALENDSO_ENCRYPTION_KEY=<your-key>

# Database (PostgreSQL)
DATABASE_URL=postgresql://user:password@localhost:5432/calcom

# Email (Optional for development)
EMAIL_FROM=notifications@yourdomain.com
EMAIL_SERVER_HOST=smtp.gmail.com
EMAIL_SERVER_PORT=587
EMAIL_SERVER_USER=your-email@gmail.com
EMAIL_SERVER_PASSWORD=your-password
```

---

## Docker Commands Reference

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild containers
docker-compose up -d --build

# Remove volumes (reset data)
docker-compose down -v

# Check container status
docker-compose ps
```

---

## Troubleshooting Quick Fixes

### Port 3000 in use
```bash
# Change port in .env
echo "PORT=3001" >> .env
```

### Clear cache and reinstall
```bash
rm -rf node_modules
rm yarn.lock
yarn cache clean
yarn
```

### Reset database
```bash
yarn db:reset
```

### Check Node version
```bash
node --version
nvm current
```

### Update dependencies
```bash
yarn upgrade-interactive --latest
```

---

## Development Workflow

1. **Make changes** to code
2. **Save file** (hot-reload happens automatically)
3. **Check browser** (http://localhost:3000)
4. **Run tests** `yarn test`
5. **Lint code** `yarn lint`
6. **Commit changes** `git commit -m "Your message"`

---

## First-Time Setup Checklist

- [ ] Clone repository
- [ ] Install dependencies (`yarn`)
- [ ] Copy `.env.example` to `.env`
- [ ] Generate and add `NEXTAUTH_SECRET`
- [ ] Generate and add `CALENDSO_ENCRYPTION_KEY`
- [ ] Configure database connection (if needed)
- [ ] Run `nvm install && nvm use`
- [ ] Start development server (`yarn dev`)
- [ ] Access http://localhost:3000
- [ ] Create first user account
- [ ] Verify everything works

---

## Useful Links

- 📘 [Full Setup Guide](./SETUP_GUIDE.md)
- 🔧 [Automated Setup Script](./setup-calcom.sh)
- 🌐 [Cal.com Docs](https://cal.com/docs)
- 💬 [Discord Community](https://cal.com/discord)
- 🐙 [GitHub Repo](https://github.com/calcom/cal.com)

---

**Pro Tip:** Bookmark this page for quick reference during development! 🚀

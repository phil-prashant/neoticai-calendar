# Cal.com Setup FAQ

Frequently Asked Questions about setting up and running Cal.com.

## General Questions

### What is Cal.com?

Cal.com is an open-source scheduling infrastructure that allows you to manage appointments, meetings, and events. It's a powerful alternative to proprietary scheduling tools like Calendly, offering self-hosting capabilities and extensive customization options.

### Do I need to pay for Cal.com?

No, Cal.com is open-source and free to use. You can self-host it without any cost. However, Cal.com also offers a paid hosted solution with additional features and support.

### What are the system requirements?

**Minimum Requirements:**
- **OS:** Linux, macOS, or Windows 10/11
- **Node.js:** v18.x or later
- **RAM:** 4GB minimum (8GB recommended for development)
- **Disk Space:** 5GB free space
- **Database:** PostgreSQL 12+ or MySQL 8+

**Required Software:**
- Git
- Yarn package manager
- nvm (Node Version Manager)
- OpenSSL (for generating keys)
- Docker (optional, for containerized development)

---

## Installation Questions

### Can I use npm instead of Yarn?

While technically possible, Cal.com is optimized for Yarn and uses Yarn workspaces for its monorepo structure. Using npm may cause issues with dependency management. It's strongly recommended to use Yarn.

### Do I need Docker to run Cal.com?

No, Docker is optional. You can run Cal.com directly on your machine with Node.js and a PostgreSQL database. However, Docker simplifies the setup by providing all required services in containers.

### How long does the setup take?

- **Cloning:** 1-2 minutes
- **Dependency installation:** 5-15 minutes (depends on internet speed)
- **Configuration:** 2-5 minutes
- **First startup:** 2-3 minutes

Total time: Approximately 15-30 minutes for a complete setup.

### Can I run Cal.com on Windows?

Yes! Cal.com works on Windows, but you need to:
1. Use the `-c core.symlinks=true` flag when cloning
2. Ensure you have Git Bash or WSL installed
3. Consider using Docker for a smoother experience

---

## Environment Configuration

### What is NEXTAUTH_SECRET and why do I need it?

`NEXTAUTH_SECRET` is a secret key used by NextAuth.js for encrypting session tokens and cookies. It must be a random string and should never be shared publicly.

Generate it with:
```bash
openssl rand -base64 32
```

### What is CALENDSO_ENCRYPTION_KEY?

`CALENDSO_ENCRYPTION_KEY` is used by Cal.com to encrypt sensitive data like API keys and credentials stored in the database. Like `NEXTAUTH_SECRET`, it must be a random, secure string.

### Can I use the same key for both NEXTAUTH_SECRET and CALENDSO_ENCRYPTION_KEY?

Technically yes, but it's not recommended for security reasons. Always generate two separate keys.

### Where do I find my database connection string?

**For local PostgreSQL:**
```env
DATABASE_URL="postgresql://username:password@localhost:5432/calcom"
```

**For Docker:**
```env
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/calcom"
```

**For cloud databases (e.g., Heroku, Railway):**
Copy the connection string from your database provider's dashboard.

### Do I need to configure email settings for development?

No, email settings are optional for local development. You can set up Cal.com and test most features without configuring email. However, some features like password reset and email notifications won't work.

---

## Node.js and Dependencies

### What Node.js version should I use?

Cal.com requires Node.js v18.x or later. The exact version is specified in the `.nvmrc` file in the repository. Use `nvm install && nvm use` to automatically use the correct version.

### What is nvm and do I need it?

nvm (Node Version Manager) allows you to install and switch between different Node.js versions. While not strictly required, it's highly recommended because:
- Different projects may need different Node.js versions
- It makes switching versions easy
- It's the recommended way to manage Node.js

### Why does yarn install take so long?

Cal.com is a large monorepo with many packages and dependencies. The first installation needs to:
- Download hundreds of packages
- Build native modules
- Set up workspaces
- Compile TypeScript

Subsequent installs will be faster because of caching.

### Can I skip dependency installation?

No, you must run `yarn` to install all dependencies before running Cal.com.

---

## Database Questions

### Do I need to create a database manually?

It depends on your setup:

**Docker:** No, the database is created automatically.

**Local PostgreSQL:** Yes, create the database:
```sql
CREATE DATABASE calcom;
```

**Cloud database:** The database should already exist; just use the connection string.

### What database does Cal.com support?

Cal.com officially supports:
- **PostgreSQL** (recommended)
- **MySQL**

### Can I use SQLite for development?

No, Cal.com requires PostgreSQL or MySQL. SQLite is not supported due to the use of advanced database features.

### How do I reset the database?

```bash
yarn db:reset
```

**Warning:** This deletes all data. Use only in development.

### How do I view the database?

Use Prisma Studio:
```bash
yarn db:studio
```

This opens a web interface at http://localhost:5555 where you can browse and edit database records.

---

## Development Questions

### What port does Cal.com run on?

By default, Cal.com runs on **port 3000**. You can change this by adding `PORT=<number>` to your `.env` file.

### How do I stop the development server?

Press `Ctrl + C` in the terminal where `yarn dev` is running.

### Does the server auto-reload when I make changes?

Yes, Cal.com uses Next.js which provides hot-reloading. Changes to most files will be reflected immediately without restarting the server.

### Can I run multiple Cal.com instances?

Yes, but each instance needs:
- A different port
- A separate database (or different schema)
- Its own `.env` configuration

### How do I access the admin panel?

1. Start the server: `yarn dev`
2. Navigate to: http://localhost:3000
3. Create an account (first user becomes admin)
4. Access admin features from your dashboard

---

## Docker Questions

### What's the difference between `yarn dev` and `yarn dx`?

- **`yarn dev`:** Runs the application directly on your machine. You need to have PostgreSQL installed separately.
- **`yarn dx`:** Runs the application with all services (database, mail server, etc.) in Docker containers. Easier setup but requires Docker.

### How do I stop Docker containers?

```bash
docker-compose down
```

To also remove all data:
```bash
docker-compose down -v
```

### Can I use Docker for production?

Yes, Cal.com provides production-ready Docker configurations. However, you'll need to configure additional settings for production use.

### How do I see Docker logs?

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f web
```

---

## Troubleshooting

### Port 3000 is already in use. What should I do?

**Option 1:** Change the port
```env
# Add to .env
PORT=3001
```

**Option 2:** Find and stop the process using port 3000
```bash
# Linux/macOS
lsof -i :3000
kill -9 <PID>

# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### I'm getting "Module not found" errors

Try a clean reinstall:
```bash
rm -rf node_modules
yarn cache clean
yarn
```

### The setup script doesn't work on my system

Try the manual setup instead. Follow the step-by-step instructions in [SETUP_GUIDE.md](./SETUP_GUIDE.md).

### I can't generate keys with OpenSSL on Windows

**Option 1:** Use Git Bash (comes with Git for Windows)

**Option 2:** Use an online generator (for development only!)
- https://generate-secret.vercel.app/32

**Option 3:** Install OpenSSL for Windows
- https://slproweb.com/products/Win32OpenSSL.html

### How do I completely reset and start over?

```bash
# Stop any running servers
# Press Ctrl+C if dev server is running

# If using Docker
docker-compose down -v

# Remove the repository
cd ..
rm -rf cal.com

# Clone and setup again
git clone https://github.com/calcom/cal.com.git
cd cal.com
yarn
cp .env.example .env
# Configure .env
yarn dev
```

---

## Project Structure

### What are "workspaces" in Cal.com?

Cal.com uses Yarn workspaces to manage its monorepo structure. The project contains multiple packages (in `packages/` and `apps/`) that are developed together but can be used independently.

### Can I work on just one part of Cal.com?

Yes, you can focus on specific workspaces:
```bash
# Run commands in specific workspace
yarn workspace @calcom/web build
yarn workspace @calcom/web dev
```

### What's in the `apps/` folder?

- **`apps/web/`:** The main web application (Next.js)
- **`apps/api/`:** API services
- Other applications and tools

### What's in the `packages/` folder?

Shared code used across multiple apps:
- **`packages/ui/`:** UI components
- **`packages/lib/`:** Utility functions
- **`packages/prisma/`:** Database schema
- **`packages/emails/`:** Email templates
- And many more...

---

## Contributing

### Can I contribute to Cal.com?

Yes! Cal.com is open-source and welcomes contributions. Check the [Contributing Guide](https://github.com/calcom/cal.com/blob/main/CONTRIBUTING.md) for details.

### Do I need to fork the repository to contribute?

Yes, follow the standard GitHub workflow:
1. Fork the repository
2. Clone your fork
3. Create a feature branch
4. Make changes
5. Submit a pull request

### How do I run tests?

```bash
# Run all tests
yarn test

# Run tests in watch mode
yarn test:watch

# Run E2E tests
yarn test:e2e
```

---

## Production Deployment

### Can I deploy Cal.com to production?

Yes, but this guide focuses on local development. For production deployment, refer to:
- [Cal.com Deployment Docs](https://cal.com/docs/self-hosting/deployment)
- [Docker Deployment](https://cal.com/docs/self-hosting/docker)

### What's the recommended hosting for Cal.com?

Popular options include:
- **Vercel** (easiest for Next.js)
- **Railway**
- **Heroku**
- **DigitalOcean**
- **AWS/GCP/Azure**
- **Self-hosted VPS**

### Do I need to change environment variables for production?

Yes, you'll need to:
- Use a production database URL
- Set `NEXTAUTH_URL` to your domain
- Configure email settings
- Set up additional integrations
- And more...

Refer to the Cal.com documentation for a complete production checklist.

---

## Security

### Is it safe to share my .env file?

**NO!** Never share your `.env` file. It contains sensitive secrets and credentials. Always add `.env` to your `.gitignore` file.

### How do I keep my secrets secure?

1. Never commit `.env` to Git
2. Use different secrets for development and production
3. Rotate secrets periodically
4. Use environment variable managers in production
5. Never share secrets in public channels

### Can I use the same secrets in development and production?

No, always use different secrets for different environments. Development secrets should never be used in production.

---

## Getting Help

### Where can I get help if I'm stuck?

1. **Documentation:** https://cal.com/docs
2. **Troubleshooting Guide:** [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
3. **GitHub Issues:** https://github.com/calcom/cal.com/issues
4. **Discord Community:** https://cal.com/discord
5. **GitHub Discussions:** https://github.com/calcom/cal.com/discussions

### How do I report a bug?

1. Check if the bug already exists in [GitHub Issues](https://github.com/calcom/cal.com/issues)
2. If not, create a new issue with:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - System information (OS, Node version, etc.)
   - Screenshots if applicable

### Where can I request a feature?

Use [GitHub Discussions](https://github.com/calcom/cal.com/discussions) to discuss feature ideas with the community.

---

## Additional Resources

- **Official Website:** https://cal.com
- **Documentation:** https://cal.com/docs
- **GitHub Repository:** https://github.com/calcom/cal.com
- **Discord Community:** https://cal.com/discord
- **Twitter:** https://twitter.com/calcom
- **Blog:** https://cal.com/blog

---

**Still have questions?** Join the [Cal.com Discord community](https://cal.com/discord) for help! 🚀

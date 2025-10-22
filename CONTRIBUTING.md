# Contributing to Neoticai Calendar Setup Helper

Thank you for your interest in improving the Cal.com setup documentation! This guide will help you contribute effectively.

## How to Contribute

### Reporting Issues

If you find errors, outdated information, or missing steps in the documentation:

1. Check [existing issues](https://github.com/phil-prashant/neoticai-calendar/issues) to avoid duplicates
2. Create a new issue with:
   - Clear description of the problem
   - Steps to reproduce (if applicable)
   - Suggested fix (if you have one)
   - Screenshots or error messages (if relevant)

### Suggesting Improvements

We welcome suggestions for:
- Additional troubleshooting scenarios
- Better explanations of commands
- New helper scripts or utilities
- Alternative setup methods
- Additional documentation

### Submitting Changes

1. **Fork the repository**
   ```bash
   # Click "Fork" on GitHub, then:
   git clone https://github.com/YOUR_USERNAME/neoticai-calendar.git
   cd neoticai-calendar
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-improvement-name
   ```

3. **Make your changes**
   - Update documentation files (README.md, SETUP_GUIDE.md, etc.)
   - Test any scripts or commands you modify
   - Ensure formatting is consistent

4. **Test your changes**
   ```bash
   # For script changes
   bash -n setup-calcom.sh
   
   # For documentation, verify:
   # - All links work
   # - Code blocks are properly formatted
   # - Commands are accurate
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Brief description of changes"
   ```

6. **Push and create Pull Request**
   ```bash
   git push origin feature/your-improvement-name
   # Then create a PR on GitHub
   ```

## Documentation Standards

### Writing Style

- **Be clear and concise** - Users should understand commands quickly
- **Use active voice** - "Run this command" not "This command should be run"
- **Include context** - Explain what each command does
- **Be platform-aware** - Note differences for Linux/macOS/Windows
- **Test everything** - Ensure all commands and instructions work

### Code Blocks

Use proper syntax highlighting:

```bash
# Good
git clone https://github.com/calcom/cal.com.git
```

```
# Bad - no language specified
git clone https://github.com/calcom/cal.com.git
```

### Structure

- Use clear headings (##, ###)
- Include table of contents for long documents
- Group related information together
- Use bullet points and numbered lists appropriately

## What to Update

### When Cal.com Changes

If Cal.com updates its setup process, please update:

1. **SETUP_GUIDE.md** - Main installation steps
2. **QUICK_REFERENCE.md** - Command reference
3. **setup-calcom.sh** - Automation script
4. **TROUBLESHOOTING.md** - New common issues
5. **README.md** - If major changes occur

### Version Notes

When Cal.com releases major versions with breaking changes:
- Create a note in the relevant documentation
- Update commands if they change
- Add migration guides if needed

## Testing Checklist

Before submitting documentation changes:

- [ ] All commands are accurate and tested
- [ ] Code blocks use proper syntax highlighting
- [ ] Links work and point to correct resources
- [ ] Formatting is consistent with existing docs
- [ ] No typos or grammatical errors
- [ ] Screenshots are up-to-date (if included)
- [ ] Instructions work on multiple platforms (if applicable)

Before submitting script changes:

- [ ] Script syntax is valid (`bash -n script.sh`)
- [ ] Script runs without errors
- [ ] Error handling is appropriate
- [ ] Output is clear and helpful
- [ ] Script is executable (`chmod +x`)

## Questions?

- Open an issue for clarification
- Check existing documentation
- Review closed PRs for examples

## Code of Conduct

- Be respectful and constructive
- Focus on improving documentation quality
- Help others learn and contribute
- Give credit where credit is due

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for helping make Cal.com setup easier for everyone! 🎉

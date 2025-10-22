#!/bin/bash

# Cal.com Automated Setup Script
# This script automates the setup process described in SETUP_GUIDE.md

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
print_step "Checking prerequisites..."

if ! command_exists git; then
    print_error "git is not installed. Please install git first."
    exit 1
fi
print_success "git is installed"

if ! command_exists node; then
    print_warning "node is not installed. Will attempt to install with nvm."
fi

if ! command_exists yarn; then
    print_error "yarn is not installed. Please install yarn first:"
    echo "  npm install -g yarn"
    exit 1
fi
print_success "yarn is installed"

if ! command_exists nvm; then
    print_warning "nvm is not detected. It's recommended to install nvm for Node version management."
    echo "  Visit: https://github.com/nvm-sh/nvm#installing-and-updating"
fi

if ! command_exists openssl; then
    print_error "openssl is not installed. Please install openssl first."
    exit 1
fi
print_success "openssl is installed"

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS="windows"
fi
print_success "Detected OS: $OS"

echo ""
print_step "Starting Cal.com setup..."
echo ""

# Step 1: Clone repository
print_step "Step 1: Cloning Cal.com repository..."

if [ -d "cal.com" ]; then
    print_warning "Directory 'cal.com' already exists. Skipping clone."
else
    if [ "$OS" == "windows" ]; then
        print_step "Cloning with symlink preservation for Windows..."
        git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
    else
        git clone https://github.com/calcom/cal.com.git
    fi
    print_success "Repository cloned successfully"
fi

# Navigate to repository
cd cal.com

# Step 5: Set Node.js version (before installing dependencies)
print_step "Step 5: Setting correct Node.js version..."

if command_exists nvm; then
    # Source nvm if not already available in the script
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    if [ -f ".nvmrc" ]; then
        print_step "Installing Node.js version from .nvmrc..."
        nvm install
        nvm use
        print_success "Node.js version set successfully"
    else
        print_warning ".nvmrc file not found. Using current Node.js version."
    fi
else
    print_warning "nvm not available. Using current Node.js version: $(node --version)"
fi

# Step 3: Install dependencies
print_step "Step 3: Installing dependencies with Yarn..."
print_warning "This may take several minutes..."

yarn install

print_success "Dependencies installed successfully"

# Step 4: Configure environment variables
print_step "Step 4: Configuring environment variables..."

if [ -f ".env" ]; then
    print_warning ".env file already exists. Skipping creation."
    read -p "Do you want to regenerate encryption keys? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        REGENERATE=true
    else
        REGENERATE=false
    fi
else
    print_step "Creating .env file from .env.example..."
    cp .env.example .env
    print_success ".env file created"
    REGENERATE=true
fi

if [ "$REGENERATE" = true ]; then
    print_step "Generating encryption keys..."
    
    NEXTAUTH_SECRET=$(openssl rand -base64 32)
    CALENDSO_ENCRYPTION_KEY=$(openssl rand -base64 32)
    
    print_success "Keys generated"
    
    # Update .env file with generated keys
    if [[ "$OS" == "mac" ]]; then
        # macOS requires empty string after -i
        sed -i '' "s|NEXTAUTH_SECRET=.*|NEXTAUTH_SECRET=$NEXTAUTH_SECRET|" .env
        sed -i '' "s|CALENDSO_ENCRYPTION_KEY=.*|CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY|" .env
    else
        sed -i "s|NEXTAUTH_SECRET=.*|NEXTAUTH_SECRET=$NEXTAUTH_SECRET|" .env
        sed -i "s|CALENDSO_ENCRYPTION_KEY=.*|CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY|" .env
    fi
    
    print_success "Environment variables configured"
fi

echo ""
print_success "========================================="
print_success "Cal.com setup completed successfully! 🚀"
print_success "========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Navigate to the repository:"
echo "   ${YELLOW}cd cal.com${NC}"
echo ""
echo "2. Review and customize your .env file if needed:"
echo "   ${YELLOW}nano .env${NC}"
echo ""
echo "3. Start the development server:"
echo "   ${YELLOW}yarn dev${NC}"
echo ""
echo "4. Open your browser to:"
echo "   ${YELLOW}http://localhost:3000${NC}"
echo ""
echo "Alternative (with Docker):"
echo "   ${YELLOW}yarn dx${NC}"
echo ""
echo "For more information, see SETUP_GUIDE.md"
echo ""

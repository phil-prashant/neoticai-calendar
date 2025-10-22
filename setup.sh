#!/bin/bash

###############################################################################
# Cal.com Automated Setup Script
# 
# This script automates the setup process for Cal.com development environment.
# It will clone the repository, install dependencies, configure environment
# variables, and start the development server.
###############################################################################

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Print header
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║         Cal.com Automated Setup Script                    ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check prerequisites
print_status "Checking prerequisites..."

if ! command_exists git; then
    print_error "Git is not installed. Please install Git first."
    exit 1
fi
print_success "Git is installed"

if ! command_exists node; then
    print_error "Node.js is not installed. Please install Node.js first."
    exit 1
fi
print_success "Node.js is installed ($(node --version))"

if ! command_exists yarn; then
    print_warning "Yarn is not installed. Installing Yarn globally..."
    npm install -g yarn
fi
print_success "Yarn is installed ($(yarn --version))"

if ! command_exists openssl; then
    print_error "OpenSSL is not installed. Please install OpenSSL first."
    exit 1
fi
print_success "OpenSSL is installed"

# Check if nvm is available
if command_exists nvm; then
    print_success "nvm is installed"
    NVM_AVAILABLE=true
else
    print_warning "nvm is not installed. Will skip Node version management."
    NVM_AVAILABLE=false
fi

echo ""

# Step 1: Clone the repository
print_status "Step 1: Cloning Cal.com repository..."

if [ -d "cal.com" ]; then
    print_warning "Directory 'cal.com' already exists."
    read -p "Do you want to remove it and clone again? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf cal.com
        print_status "Removed existing directory."
    else
        print_status "Using existing directory."
    fi
fi

if [ ! -d "cal.com" ]; then
    # Detect OS for Windows-specific clone
    if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        print_status "Windows detected. Cloning with symlinks preserved..."
        git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
    else
        git clone https://github.com/calcom/cal.com.git
    fi
    print_success "Repository cloned successfully"
else
    print_success "Using existing repository"
fi

# Step 2: Navigate to directory
cd cal.com
print_success "Changed directory to cal.com"

echo ""

# Step 3: Install dependencies
print_status "Step 3: Installing dependencies (this may take a few minutes)..."
yarn install
print_success "Dependencies installed successfully"

echo ""

# Step 4: Configure environment variables
print_status "Step 4: Configuring environment variables..."

if [ -f ".env" ]; then
    print_warning ".env file already exists."
    read -p "Do you want to regenerate it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm .env
    else
        print_status "Keeping existing .env file"
        SKIP_ENV=true
    fi
fi

if [ ! -f ".env" ] && [ "$SKIP_ENV" != true ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        print_success "Created .env file from .env.example"
        
        # Generate keys
        print_status "Generating encryption keys..."
        NEXTAUTH_SECRET=$(openssl rand -base64 32)
        CALENDSO_ENCRYPTION_KEY=$(openssl rand -base64 32)
        
        # Update .env file with generated keys
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            sed -i '' "s|NEXTAUTH_SECRET=.*|NEXTAUTH_SECRET=\"$NEXTAUTH_SECRET\"|g" .env
            sed -i '' "s|CALENDSO_ENCRYPTION_KEY=.*|CALENDSO_ENCRYPTION_KEY=\"$CALENDSO_ENCRYPTION_KEY\"|g" .env
        else
            # Linux
            sed -i "s|NEXTAUTH_SECRET=.*|NEXTAUTH_SECRET=\"$NEXTAUTH_SECRET\"|g" .env
            sed -i "s|CALENDSO_ENCRYPTION_KEY=.*|CALENDSO_ENCRYPTION_KEY=\"$CALENDSO_ENCRYPTION_KEY\"|g" .env
        fi
        
        print_success "Environment variables configured with generated keys"
    else
        print_warning ".env.example not found. You'll need to configure .env manually."
    fi
fi

echo ""

# Step 5: Node version management
if [ "$NVM_AVAILABLE" = true ] && [ -f ".nvmrc" ]; then
    print_status "Step 5: Setting up Node.js version..."
    
    # Source nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    nvm install
    nvm use
    print_success "Node.js version configured"
else
    print_status "Step 5: Skipping Node.js version management"
fi

echo ""

# Step 6: Show next steps
print_success "Setup completed successfully! 🎉"
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                    Next Steps                              ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "To start the development server:"
echo "  ${GREEN}yarn dev${NC}"
echo ""
echo "To use Docker-based development:"
echo "  ${GREEN}yarn dx${NC}"
echo ""
echo "The application will be available at:"
echo "  ${GREEN}http://localhost:3000${NC}"
echo ""
echo "To view the database:"
echo "  ${GREEN}yarn prisma:studio${NC}"
echo ""
echo "For more information, check SETUP_GUIDE.md"
echo ""

# Ask if user wants to start dev server
read -p "Do you want to start the development server now? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Starting development server..."
    yarn dev
fi

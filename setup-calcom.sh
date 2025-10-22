#!/bin/bash

# Cal.com Automated Setup Script
# This script automates the setup process for the Cal.com project

set -e  # Exit on error

# Colors for output
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

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required tools are installed
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    local missing_tools=()
    
    if ! command -v git &> /dev/null; then
        missing_tools+=("git")
    fi
    
    if ! command -v node &> /dev/null; then
        missing_tools+=("node")
    fi
    
    if ! command -v yarn &> /dev/null; then
        missing_tools+=("yarn")
    fi
    
    if ! command -v nvm &> /dev/null; then
        print_warning "nvm is not installed. You may need to install it manually."
    fi
    
    if ! command -v openssl &> /dev/null; then
        missing_tools+=("openssl")
    fi
    
    if [ ${#missing_tools[@]} -ne 0 ]; then
        print_error "Missing required tools: ${missing_tools[*]}"
        print_error "Please install the missing tools and try again."
        exit 1
    fi
    
    print_success "All prerequisites are installed!"
}

# Clone the repository
clone_repository() {
    print_status "Cloning Cal.com repository..."
    
    if [ -d "cal.com" ]; then
        print_warning "Directory 'cal.com' already exists. Skipping clone."
        return
    fi
    
    # Detect OS and use appropriate clone command
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        print_status "Windows detected. Using symlink preservation..."
        git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
    else
        git clone https://github.com/calcom/cal.com.git
    fi
    
    print_success "Repository cloned successfully!"
}

# Navigate to repository
navigate_to_repo() {
    print_status "Navigating to cal.com directory..."
    cd cal.com || exit 1
    print_success "Changed directory to cal.com"
}

# Install dependencies
install_dependencies() {
    print_status "Installing dependencies with Yarn..."
    print_warning "This may take several minutes..."
    yarn
    print_success "Dependencies installed successfully!"
}

# Configure environment variables
configure_env() {
    print_status "Configuring environment variables..."
    
    if [ -f ".env" ]; then
        print_warning ".env file already exists. Skipping configuration."
        read -p "Do you want to overwrite it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return
        fi
    fi
    
    # Copy example file
    cp .env.example .env
    print_success "Created .env file from .env.example"
    
    # Generate keys
    print_status "Generating encryption keys..."
    NEXTAUTH_SECRET=$(openssl rand -base64 32)
    CALENDSO_ENCRYPTION_KEY=$(openssl rand -base64 32)
    
    # Update .env file
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s|NEXTAUTH_SECRET=.*|NEXTAUTH_SECRET=$NEXTAUTH_SECRET|" .env
        sed -i '' "s|CALENDSO_ENCRYPTION_KEY=.*|CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY|" .env
    else
        # Linux
        sed -i "s|NEXTAUTH_SECRET=.*|NEXTAUTH_SECRET=$NEXTAUTH_SECRET|" .env
        sed -i "s|CALENDSO_ENCRYPTION_KEY=.*|CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY|" .env
    fi
    
    print_success "Environment variables configured!"
    print_status "NEXTAUTH_SECRET: $NEXTAUTH_SECRET"
    print_status "CALENDSO_ENCRYPTION_KEY: $CALENDSO_ENCRYPTION_KEY"
}

# Setup Node version with nvm
setup_node_version() {
    print_status "Setting up Node.js version with nvm..."
    
    # Source nvm if it's installed
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        . "$HOME/.nvm/nvm.sh"
    fi
    
    if command -v nvm &> /dev/null; then
        nvm install
        nvm use
        print_success "Node.js version configured!"
    else
        print_warning "nvm not found. Using system Node.js version."
        node --version
    fi
}

# Display next steps
display_next_steps() {
    echo ""
    print_success "Setup completed successfully!"
    echo ""
    echo -e "${GREEN}=== Next Steps ===${NC}"
    echo ""
    echo "1. Start the development server:"
    echo -e "   ${BLUE}cd cal.com${NC}"
    echo -e "   ${BLUE}yarn dev${NC}"
    echo ""
    echo "2. Or use Docker for containerized development:"
    echo -e "   ${BLUE}yarn dx${NC}"
    echo ""
    echo "3. Access the application at:"
    echo -e "   ${BLUE}http://localhost:3000${NC}"
    echo ""
    echo "4. To stop the development server:"
    echo -e "   ${BLUE}Press Ctrl+C${NC}"
    echo ""
    echo "5. To stop Docker containers:"
    echo -e "   ${BLUE}docker-compose down${NC}"
    echo ""
    echo -e "${GREEN}Happy coding! 🚀${NC}"
    echo ""
}

# Main execution
main() {
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   Cal.com Automated Setup Script     ║${NC}"
    echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
    echo ""
    
    check_prerequisites
    clone_repository
    navigate_to_repo
    install_dependencies
    configure_env
    setup_node_version
    display_next_steps
}

# Run main function
main

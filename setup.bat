@echo off
REM Cal.com Automated Setup Script for Windows
REM This script automates the setup process for Cal.com development environment

setlocal enabledelayedexpansion

echo.
echo ================================================================
echo          Cal.com Automated Setup Script (Windows)
echo ================================================================
echo.

REM Check prerequisites
echo [INFO] Checking prerequisites...

where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed. Please install Git first.
    exit /b 1
)
echo [SUCCESS] Git is installed

where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed. Please install Node.js first.
    exit /b 1
)
for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo [SUCCESS] Node.js is installed (!NODE_VERSION!)

where yarn >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Yarn is not installed. Installing Yarn globally...
    call npm install -g yarn
)
for /f "tokens=*" %%i in ('yarn --version') do set YARN_VERSION=%%i
echo [SUCCESS] Yarn is installed (!YARN_VERSION!)

where openssl >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] OpenSSL is not installed. You may need to install it for key generation.
    echo [INFO] You can download OpenSSL from: https://slproweb.com/products/Win32OpenSSL.html
)

echo.

REM Step 1: Clone the repository
echo [INFO] Step 1: Cloning Cal.com repository...

if exist "cal.com" (
    echo [WARNING] Directory 'cal.com' already exists.
    set /p REPLY="Do you want to remove it and clone again? (y/N): "
    if /i "!REPLY!"=="y" (
        rmdir /s /q cal.com
        echo [INFO] Removed existing directory.
    ) else (
        echo [INFO] Using existing directory.
    )
)

if not exist "cal.com" (
    echo [INFO] Windows detected. Cloning with symlinks preserved...
    git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to clone repository.
        exit /b 1
    )
    echo [SUCCESS] Repository cloned successfully
) else (
    echo [SUCCESS] Using existing repository
)

REM Step 2: Navigate to directory
cd cal.com
echo [SUCCESS] Changed directory to cal.com

echo.

REM Step 3: Install dependencies
echo [INFO] Step 3: Installing dependencies (this may take a few minutes)...
call yarn install
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies.
    exit /b 1
)
echo [SUCCESS] Dependencies installed successfully

echo.

REM Step 4: Configure environment variables
echo [INFO] Step 4: Configuring environment variables...

set SKIP_ENV=false
if exist ".env" (
    echo [WARNING] .env file already exists.
    set /p REPLY="Do you want to regenerate it? (y/N): "
    if /i "!REPLY!"=="y" (
        del .env
    ) else (
        echo [INFO] Keeping existing .env file
        set SKIP_ENV=true
    )
)

if not exist ".env" if "!SKIP_ENV!"=="false" (
    if exist ".env.example" (
        copy .env.example .env >nul
        echo [SUCCESS] Created .env file from .env.example
        
        REM Generate keys
        echo [INFO] Generating encryption keys...
        
        where openssl >nul 2>&1
        if %errorlevel% equ 0 (
            for /f "tokens=*" %%i in ('openssl rand -base64 32') do set NEXTAUTH_SECRET=%%i
            for /f "tokens=*" %%i in ('openssl rand -base64 32') do set CALENDSO_ENCRYPTION_KEY=%%i
            
            REM Update .env file with generated keys
            powershell -Command "(Get-Content .env) -replace 'NEXTAUTH_SECRET=.*', 'NEXTAUTH_SECRET=\"!NEXTAUTH_SECRET!\"' | Set-Content .env"
            powershell -Command "(Get-Content .env) -replace 'CALENDSO_ENCRYPTION_KEY=.*', 'CALENDSO_ENCRYPTION_KEY=\"!CALENDSO_ENCRYPTION_KEY!\"' | Set-Content .env"
            
            echo [SUCCESS] Environment variables configured with generated keys
        ) else (
            echo [WARNING] OpenSSL not found. Please manually generate keys and update .env file:
            echo   Run: openssl rand -base64 32
            echo   Update NEXTAUTH_SECRET and CALENDSO_ENCRYPTION_KEY in .env
        )
    ) else (
        echo [WARNING] .env.example not found. You'll need to configure .env manually.
    )
)

echo.

REM Step 5: Node version management
if exist ".nvmrc" (
    echo [INFO] Step 5: Node version management...
    echo [INFO] Found .nvmrc file. If you have nvm-windows installed, run:
    echo   nvm install
    echo   nvm use
) else (
    echo [INFO] Step 5: No .nvmrc file found, skipping Node version management
)

echo.

REM Success message
echo [SUCCESS] Setup completed successfully! 🎉
echo.
echo ================================================================
echo                         Next Steps
echo ================================================================
echo.
echo To start the development server:
echo   yarn dev
echo.
echo To use Docker-based development:
echo   yarn dx
echo.
echo The application will be available at:
echo   http://localhost:3000
echo.
echo To view the database:
echo   yarn prisma:studio
echo.
echo For more information, check SETUP_GUIDE.md
echo.

REM Ask if user wants to start dev server
set /p REPLY="Do you want to start the development server now? (y/N): "
if /i "!REPLY!"=="y" (
    echo [INFO] Starting development server...
    call yarn dev
)

endlocal

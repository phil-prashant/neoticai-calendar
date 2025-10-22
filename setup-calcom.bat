@echo off
REM Cal.com Automated Setup Script for Windows
REM This script automates the setup process for the Cal.com project on Windows

setlocal enabledelayedexpansion

echo.
echo ========================================
echo   Cal.com Automated Setup Script
echo   Windows Edition
echo ========================================
echo.

REM Check for Git
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Git is not installed or not in PATH
    echo Please install Git from https://git-scm.com/download/win
    exit /b 1
)
echo [OK] Git is installed

REM Check for Node.js
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    exit /b 1
)
echo [OK] Node.js is installed

REM Check for Yarn
where yarn >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Yarn is not installed or not in PATH
    echo Please install Yarn from https://yarnpkg.com/
    exit /b 1
)
echo [OK] Yarn is installed

REM Check for OpenSSL
where openssl >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [WARNING] OpenSSL is not installed or not in PATH
    echo You will need to generate keys manually
    set OPENSSL_AVAILABLE=0
) else (
    echo [OK] OpenSSL is installed
    set OPENSSL_AVAILABLE=1
)

echo.
echo ========================================
echo Cloning Cal.com repository...
echo ========================================
echo.

if exist "cal.com" (
    echo [WARNING] Directory 'cal.com' already exists. Skipping clone.
) else (
    echo Cloning with symlink preservation for Windows...
    git clone -c core.symlinks=true https://github.com/calcom/cal.com.git
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to clone repository
        exit /b 1
    )
    echo [SUCCESS] Repository cloned successfully!
)

echo.
echo ========================================
echo Navigating to cal.com directory...
echo ========================================
cd cal.com
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to cal.com directory
    exit /b 1
)

echo.
echo ========================================
echo Installing dependencies...
echo This may take several minutes...
echo ========================================
echo.
call yarn
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to install dependencies
    exit /b 1
)
echo [SUCCESS] Dependencies installed successfully!

echo.
echo ========================================
echo Configuring environment variables...
echo ========================================
echo.

if exist ".env" (
    echo [WARNING] .env file already exists
    set /p OVERWRITE="Do you want to overwrite it? (y/N): "
    if /i not "!OVERWRITE!"=="y" (
        echo Skipping environment configuration
        goto :skip_env
    )
)

copy .env.example .env >nul
echo [SUCCESS] Created .env file from .env.example

if %OPENSSL_AVAILABLE%==1 (
    echo Generating encryption keys...
    
    REM Generate NEXTAUTH_SECRET
    for /f "delims=" %%i in ('openssl rand -base64 32') do set NEXTAUTH_SECRET=%%i
    
    REM Generate CALENDSO_ENCRYPTION_KEY
    for /f "delims=" %%i in ('openssl rand -base64 32') do set CALENDSO_ENCRYPTION_KEY=%%i
    
    REM Update .env file using PowerShell
    powershell -Command "(Get-Content .env) -replace 'NEXTAUTH_SECRET=.*', 'NEXTAUTH_SECRET=!NEXTAUTH_SECRET!' | Set-Content .env"
    powershell -Command "(Get-Content .env) -replace 'CALENDSO_ENCRYPTION_KEY=.*', 'CALENDSO_ENCRYPTION_KEY=!CALENDSO_ENCRYPTION_KEY!' | Set-Content .env"
    
    echo [SUCCESS] Environment variables configured!
    echo NEXTAUTH_SECRET: !NEXTAUTH_SECRET!
    echo CALENDSO_ENCRYPTION_KEY: !CALENDSO_ENCRYPTION_KEY!
) else (
    echo [WARNING] OpenSSL not available. Please generate keys manually:
    echo 1. Run: openssl rand -base64 32
    echo 2. Copy the output and add it to .env as NEXTAUTH_SECRET
    echo 3. Run: openssl rand -base64 32
    echo 4. Copy the output and add it to .env as CALENDSO_ENCRYPTION_KEY
)

:skip_env

echo.
echo ========================================
echo Checking Node.js version...
echo ========================================
where nvm >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [WARNING] nvm not found. Using system Node.js version.
    node --version
) else (
    echo Using nvm to set correct Node.js version...
    call nvm install
    call nvm use
)

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Next Steps:
echo.
echo 1. Start the development server:
echo    yarn dev
echo.
echo 2. Or use Docker for containerized development:
echo    yarn dx
echo.
echo 3. Access the application at:
echo    http://localhost:3000
echo.
echo 4. To stop the development server:
echo    Press Ctrl+C
echo.
echo 5. To stop Docker containers:
echo    docker-compose down
echo.
echo Happy coding! 🚀
echo.

pause

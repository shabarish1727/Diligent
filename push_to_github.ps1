# PowerShell script to push your project to GitHub
# Run this script AFTER installing Git

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Pushing Project to GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Git is installed
try {
    $gitVersion = git --version
    Write-Host "✓ Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Git is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Git first:" -ForegroundColor Yellow
    Write-Host "1. Visit: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "2. Download and install Git" -ForegroundColor Yellow
    Write-Host "3. Restart PowerShell" -ForegroundColor Yellow
    Write-Host "4. Run this script again" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Initializing Git repository..." -ForegroundColor Yellow

# Initialize Git repository
if (Test-Path .git) {
    Write-Host "✓ Git repository already initialized" -ForegroundColor Green
} else {
    git init
    Write-Host "✓ Git repository initialized" -ForegroundColor Green
}

# Check Git config
Write-Host ""
Write-Host "Checking Git configuration..." -ForegroundColor Yellow
$userName = git config user.name
$userEmail = git config user.email

if (-not $userName -or -not $userEmail) {
    Write-Host "⚠ Git user name or email not configured" -ForegroundColor Yellow
    Write-Host ""
    $configure = Read-Host "Do you want to configure Git now? (y/n)"
    if ($configure -eq 'y' -or $configure -eq 'Y') {
        $name = Read-Host "Enter your name (or GitHub username)"
        $email = Read-Host "Enter your email"
        git config --global user.name $name
        git config --global user.email $email
        Write-Host "✓ Git configured" -ForegroundColor Green
    } else {
        Write-Host "Please configure Git manually:" -ForegroundColor Yellow
        Write-Host "  git config --global user.name 'Your Name'" -ForegroundColor Yellow
        Write-Host "  git config --global user.email 'your-email@example.com'" -ForegroundColor Yellow
        exit 1
    }
} else {
    Write-Host "✓ Git configured as: $userName <$userEmail>" -ForegroundColor Green
}

# Add files
Write-Host ""
Write-Host "Adding files to Git..." -ForegroundColor Yellow
git add .
Write-Host "✓ Files added" -ForegroundColor Green

# Check if there are changes to commit
$status = git status --short
if (-not $status) {
    Write-Host "⚠ No changes to commit (everything is already committed)" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "Committing changes..." -ForegroundColor Yellow
    git commit -m "Initial commit: Add Diligent project with e-commerce data pipeline"
    Write-Host "✓ Changes committed" -ForegroundColor Green
}

# Set branch to main
Write-Host ""
Write-Host "Setting branch to main..." -ForegroundColor Yellow
git branch -M main
Write-Host "✓ Branch set to main" -ForegroundColor Green

# Check if remote exists
Write-Host ""
Write-Host "Checking remote repository..." -ForegroundColor Yellow
$remote = git remote get-url origin 2>$null

if ($remote) {
    Write-Host "✓ Remote already exists: $remote" -ForegroundColor Green
    $updateRemote = Read-Host "Do you want to update remote URL? (y/n)"
    if ($updateRemote -eq 'y' -or $updateRemote -eq 'Y') {
        git remote set-url origin https://github.com/shabarish1727/Diligent.git
        Write-Host "✓ Remote updated" -ForegroundColor Green
    }
} else {
    Write-Host "Adding remote repository..." -ForegroundColor Yellow
    git remote add origin https://github.com/shabarish1727/Diligent.git
    Write-Host "✓ Remote added" -ForegroundColor Green
}

# Push to GitHub
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠ You will be prompted for credentials" -ForegroundColor Yellow
Write-Host "  Username: shabarish1727" -ForegroundColor Yellow
Write-Host "  Password: Use Personal Access Token (not your GitHub password)" -ForegroundColor Yellow
Write-Host ""
Write-Host "To create a Personal Access Token:" -ForegroundColor Yellow
Write-Host "1. Go to: https://github.com/settings/tokens" -ForegroundColor Yellow
Write-Host "2. Generate new token (classic)" -ForegroundColor Yellow
Write-Host "3. Select scope: repo" -ForegroundColor Yellow
Write-Host "4. Copy token and use it as password" -ForegroundColor Yellow
Write-Host ""
$continue = Read-Host "Press Enter to continue, or Ctrl+C to cancel"

try {
    git push -u origin main
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✓ Successfully pushed to GitHub!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "View your repository at:" -ForegroundColor Cyan
    Write-Host "https://github.com/shabarish1727/Diligent" -ForegroundColor Cyan
} catch {
    Write-Host ""
    Write-Host "✗ Push failed. Common issues:" -ForegroundColor Red
    Write-Host "1. Authentication failed - use Personal Access Token" -ForegroundColor Yellow
    Write-Host "2. Repository doesn't exist on GitHub - create it first" -ForegroundColor Yellow
    Write-Host "3. Network issues - check your internet connection" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Try running: git push -u origin main" -ForegroundColor Yellow
}


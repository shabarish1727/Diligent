# Git Setup Guide for Your Project

## 🚨 Current Status
Git is not installed on your system. Here's how to set it up and push your project to GitHub.

---

## Option 1: Install Git for Windows (Recommended)

### Step 1: Download Git
1. Visit: https://git-scm.com/download/win
2. Download the installer (64-bit Windows)
3. Run the installer

### Step 2: Installation Settings
During installation, use these recommended settings:
- ✅ **Git from the command line and also from 3rd-party software**
- ✅ **Use bundled OpenSSH**
- ✅ **Use the OpenSSL library**
- ✅ **Checkout Windows-style, commit Unix-style line endings**
- ✅ **Use MinTTY**
- ✅ **Enable file system caching**
- ✅ **Enable Git Credential Manager**

### Step 3: Verify Installation
After installation, **close and reopen PowerShell**, then run:
```powershell
git --version
```

You should see: `git version 2.x.x`

---

## Option 2: Install GitHub Desktop (Easier GUI Option)

If you prefer a graphical interface:
1. Visit: https://desktop.github.com/
2. Download and install GitHub Desktop
3. Sign in with your GitHub account
4. Add your local repository

---

## Step 4: Configure Git (First Time Setup)

After installing Git, configure it with your information:

```bash
git config --global user.name "shabarish1727"
git config --global user.email "your-email@example.com"
```

Replace `your-email@example.com` with your GitHub email.

---

## Step 5: Initialize Repository and Push to GitHub

Once Git is installed, run these commands in your `diligent` folder:

```bash
# Navigate to your project
cd C:\Users\HP\OneDrive\Desktop\diligent

# Initialize Git repository
git init

# Add README.md
git add README.md

# Create first commit
git commit -m "first commit"

# Set branch to main
git branch -M main

# Add GitHub remote
git remote add origin https://github.com/shabarish1727/Diligent.git

# Push to GitHub (you'll be prompted for credentials)
git push -u origin main
```

---

## Step 6: Add Your E-Commerce Project

After the initial push, add your e-commerce project:

```bash
# Add all files from ecommerce-data-project
git add ecommerce-data-project/

# Commit the project
git commit -m "Add e-commerce data project with synthetic data generation"

# Push to GitHub
git push
```

---

## Authentication Options

When you run `git push`, you'll need to authenticate:

### Option A: Personal Access Token (Recommended)
1. Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token (classic)
3. Select scopes: `repo` (full control)
4. Copy the token
5. When prompted for password, paste the token

### Option B: GitHub CLI
```bash
# Install GitHub CLI
winget install GitHub.cli

# Authenticate
gh auth login
```

---

## Troubleshooting

### "git: command not found"
- **Solution**: Restart PowerShell/Terminal after installing Git
- **Or**: Add Git to PATH manually:
  - `C:\Program Files\Git\cmd`

### "fatal: could not read Username"
- **Solution**: Use Personal Access Token instead of password
- GitHub no longer accepts passwords for Git operations

### "remote origin already exists"
- **Solution**: Remove and re-add:
  ```bash
  git remote remove origin
  git remote add origin https://github.com/shabarish1727/Diligent.git
  ```

### Authentication Issues
- Use Personal Access Token (PAT) instead of password
- Or use GitHub Desktop for easier authentication

---

## Quick Reference: All Commands

```bash
# Setup (first time only)
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"

# Initialize and push
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/shabarish1727/Diligent.git
git push -u origin main

# Add ecommerce project
git add ecommerce-data-project/
git commit -m "Add e-commerce data project"
git push
```

---

## Need More Help?

- Git Documentation: https://git-scm.com/doc
- GitHub Help: https://docs.github.com/en/get-started
- Video Tutorial: Search "Git and GitHub tutorial for beginners" on YouTube

---

**Once Git is installed, come back and we'll help you push everything to GitHub! 🚀**


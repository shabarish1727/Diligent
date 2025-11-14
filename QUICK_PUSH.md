# Quick Guide: Push to GitHub

## 🚀 Fastest Way to Push Your Project

### Step 1: Install Git (If Not Installed)

**Option A: Using Winget (Recommended)**
```powershell
winget install --id Git.Git -e --source winget
```

**Option B: Manual Download**
1. Visit: https://git-scm.com/download/win
2. Download and install
3. **Restart PowerShell** after installation

### Step 2: Verify Git Installation

Close and reopen PowerShell, then run:
```powershell
git --version
```

You should see: `git version 2.xx.x`

### Step 3: Run the Push Script

I've created an automated script for you. Just run:

```powershell
cd C:\Users\HP\OneDrive\Desktop\diligent
.\push_to_github.ps1
```

The script will:
- ✓ Check if Git is installed
- ✓ Initialize repository
- ✓ Configure Git (if needed)
- ✓ Add all files
- ✓ Commit changes
- ✓ Push to GitHub

### Step 4: Manual Push (Alternative)

If you prefer to do it manually:

```powershell
# Navigate to project
cd C:\Users\HP\OneDrive\Desktop\diligent

# Initialize Git
git init

# Configure Git (first time only)
git config --global user.name "shabarish1727"
git config --global user.email "your-email@example.com"

# Add all files
git add .

# Commit
git commit -m "Initial commit: Add Diligent project"

# Set branch to main
git branch -M main

# Add remote
git remote add origin https://github.com/shabarish1727/Diligent.git

# Push to GitHub
git push -u origin main
```

## 🔐 Authentication

When pushing, you'll be asked for credentials:

- **Username**: `shabarish1727`
- **Password**: Use a **Personal Access Token** (NOT your GitHub password)

### Create Personal Access Token:

1. Go to: https://github.com/settings/tokens
2. Click: **Generate new token (classic)**
3. Name it: `Diligent Project`
4. Select scope: ✅ **repo** (check this box)
5. Click: **Generate token**
6. **COPY THE TOKEN** (you won't see it again!)
7. Use this token as your password when pushing

## ✅ Verify Upload

After pushing, visit:
https://github.com/shabarish1727/Diligent

You should see all your files there!

## 🆘 Troubleshooting

### "git: command not found"
- Git is not installed or not in PATH
- Restart PowerShell after installing Git
- Check installation: `git --version`

### "Authentication failed"
- Use Personal Access Token, not password
- Make sure token has `repo` scope

### "Repository not found"
- Create the repository on GitHub first:
  1. Go to: https://github.com/new
  2. Name: `Diligent`
  3. Don't initialize with README
  4. Create repository
  5. Then push

### "Permission denied"
- Check if you have access to the repository
- Verify your GitHub username is correct

---

**Need help?** See `GIT_SETUP_GUIDE.md` for detailed instructions.


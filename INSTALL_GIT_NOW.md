# ⚡ Install Git NOW - Step by Step

## Method 1: Direct Download (Fastest - 5 minutes)

### Step 1: Download Git
1. Open your web browser
2. Go to: **https://git-scm.com/download/win**
3. Click the download button (it will download automatically)
4. The file will be named something like: `Git-2.51.2-64-bit.exe`

### Step 2: Install Git
1. Find the downloaded file in your **Downloads** folder
2. **Double-click** the file to run it
3. Click **Next** through all the screens (default options are fine)
4. When installation completes, click **Finish**

### Step 3: Restart PowerShell
1. **Close this PowerShell window completely**
2. Open PowerShell again (or Command Prompt)
3. Navigate to your project:
   ```powershell
   cd C:\Users\HP\OneDrive\Desktop\diligent
   ```

### Step 4: Verify Git is Installed
```powershell
git --version
```

You should see: `git version 2.xx.x`

### Step 5: Run These Commands

```powershell
# Configure Git (first time only)
git config --global user.name "shabarish1727"
git config --global user.email "your-email@example.com"

# Initialize repository
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: Add Diligent project with e-commerce data pipeline"

# Set branch to main
git branch -M main

# Add GitHub remote
git remote add origin https://github.com/shabarish1727/Diligent.git

# Push to GitHub (you'll be prompted for credentials)
git push -u origin main
```

---

## 🔐 When Pushing - Authentication Required

When you run `git push`, you'll be asked for:
- **Username**: `shabarish1727`
- **Password**: Use a **Personal Access Token** (NOT your GitHub password)

### Create Personal Access Token:

1. Go to: https://github.com/settings/tokens
2. Click: **"Generate new token"** → **"Generate new token (classic)"**
3. **Note**: Give it a name like "Diligent Project"
4. **Expiration**: Choose your preference (90 days or No expiration)
5. **Select scopes**: Check ✅ **`repo`** (this gives full repository access)
6. Click: **"Generate token"** (scroll to bottom)
7. **⚠️ IMPORTANT**: Copy the token immediately! You won't see it again!
8. Use this token as your password when pushing

---

## Method 2: Using Chocolatey (If Installed)

If you have Chocolatey installed:
```powershell
choco install git
```

Then restart PowerShell and continue with Step 4 above.

---

## Method 3: GitHub Desktop (Easier GUI Alternative)

If you prefer a graphical interface:

1. Download: https://desktop.github.com/
2. Install GitHub Desktop
3. Sign in with your GitHub account
4. Click **File** → **Add Local Repository**
5. Browse to: `C:\Users\HP\OneDrive\Desktop\diligent`
6. Click **Publish repository** to GitHub

---

## ✅ After Installation Checklist

- [ ] Git installed
- [ ] PowerShell restarted
- [ ] `git --version` works
- [ ] Git configured with name and email
- [ ] Personal Access Token created
- [ ] Repository pushed to GitHub

---

## 🆘 Need Help?

If you get stuck:
1. Make sure you **closed and reopened PowerShell** after installing Git
2. Check if Git is in PATH: `where.exe git`
3. Try restarting your computer if Git still isn't found
4. See `GIT_SETUP_GUIDE.md` for detailed troubleshooting

---

**Quick Links:**
- Download Git: https://git-scm.com/download/win
- Create Token: https://github.com/settings/tokens
- Your Repo: https://github.com/shabarish1727/Diligent


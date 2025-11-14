# Quick Git Installation Guide

## 🚀 Fastest Way to Install Git on Windows

### Method 1: Using Winget (If Available)
Open PowerShell as Administrator and run:
```powershell
winget install --id Git.Git -e --source winget
```

### Method 2: Direct Download
1. **Download Git**: Visit https://git-scm.com/download/win
2. **Run Installer**: Double-click the downloaded `.exe` file
3. **Default Options**: Click "Next" through the installation (defaults are fine)
4. **Restart Terminal**: Close and reopen PowerShell after installation

### Method 3: Using Chocolatey (If Installed)
```powershell
choco install git
```

---

## ✅ Verify Installation

After installation, **close and reopen PowerShell**, then run:

```powershell
git --version
```

You should see something like: `git version 2.xx.x`

---

## ⚙️ Quick Configuration

After Git is installed, configure it once:

```powershell
git config --global user.name "shabarish1727"
git config --global user.email "your-email@example.com"
```

**Replace `your-email@example.com` with your GitHub email address.**

---

## 📤 Then Push to GitHub

Once Git is installed and configured, you can run your original commands:

```powershell
cd C:\Users\HP\OneDrive\Desktop\diligent
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/shabarish1727/Diligent.git
git push -u origin main
```

**Note**: When prompted for credentials, use a **Personal Access Token** (not your password).
- Create token: GitHub → Settings → Developer settings → Personal access tokens
- Select scope: `repo`

---

## 🆘 Need Help?

See `GIT_SETUP_GUIDE.md` for detailed troubleshooting and authentication help.


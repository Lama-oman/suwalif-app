# Quick Deploy to Netlify (Recommended)

## Step 1: Go to Netlify Drop
**URL:** https://app.netlify.com/drop

## Step 2: Drag & Drop
Drag this entire folder (`docs/`) and drop it on the Netlify page

## Step 3: Done!
You'll instantly get a live URL like `https://abc123.netlify.app`

---

# Alternative: GitHub Pages

## Step 1: Create GitHub Repo
1. Go to https://github.com/new
2. Name: `suwalif-app`
3. Make it **Public**

## Step 2: Push Code
```bash
cd /Users/lama/.openclaw/workspace/nightly-build-2026-02-06
git remote add origin https://github.com/YOUR_USERNAME/suwalif-app.git
git push -u origin main
```

## Step 3: Enable Pages
1. Repo Settings → Pages
2. Source: Deploy from branch
3. Branch: main /docs folder
4. Save

Your app will be at: `https://YOUR_USERNAME.github.io/suwalif-app/`

---

# Alternative: Firebase Hosting

```bash
# One-time setup
npm install -g firebase-tools
firebase login

# Deploy
cd /Users/lama/.openclaw/workspace/nightly-build-2026-02-06/docs
firebase init hosting
firebase deploy
```

---

# Files Ready to Deploy

All built files are in:
```
/Users/lama/.openclaw/workspace/nightly-build-2026-02-06/docs/
├── index.html
├── main.dart.js (the Flutter app)
├── assets/
└── ...
```

Just upload this `docs/` folder to any static hosting!
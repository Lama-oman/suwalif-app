# 🚀 Deployment Guide for Suwalif

## Quick Start - Test Locally

### Option 1: Using the Provided Script
```bash
cd /Users/lama/.openclaw/workspace/nightly-build-2026-02-06
./start-server.sh
```
Then open: http://localhost:8765

### Option 2: Using Python Directly
```bash
cd /Users/lama/.openclaw/workspace/nightly-build-2026-02-06/docs
python3 -m http.server 8765
```
Then open: http://localhost:8765

### Option 3: Using Node.js (if you have npx)
```bash
cd /Users/lama/.openclaw/workspace/nightly-build-2026-02-06/docs
npx serve .
```

---

## Deploy to GitHub Pages (Recommended - Free)

### Step 1: Create GitHub Repository
1. Go to https://github.com/new
2. Create a new repository called `suwalif-app` (or any name)
3. Make it public

### Step 2: Push Your Code
```bash
cd /Users/lama/.openclaw/workspace/nightly-build-2026-02-06

# Add your GitHub repository
git remote add origin https://github.com/YOUR_USERNAME/suwalif-app.git

# Push to main branch
git push -u origin main
```

### Step 3: Enable GitHub Pages
1. Go to your repository on GitHub
2. Click **Settings** (tab at the top)
3. Scroll down to **Pages** (left sidebar)
4. Under "Source", select **Deploy from a branch**
5. Select branch: **main**
6. Select folder: **/docs**
7. Click **Save**

### Step 4: Access Your Live App
- Wait 2-3 minutes for deployment
- Your app will be at: `https://YOUR_USERNAME.github.io/suwalif-app/`

---

## Deploy to Firebase Hosting (Free Tier)

### Step 1: Install Firebase CLI
```bash
npm install -g firebase-tools
```

### Step 2: Login to Firebase
```bash
firebase login
```

### Step 3: Initialize Firebase Project
```bash
cd /Users/lama/.openclaw/workspace/nightly-build-2026-02-06
firebase init hosting
```
- Select "Create a new project"
- Give it a name (e.g., "suwalif-app")
- Set public directory to: `suwalif_app/build/web`
- Configure as single-page app: **Yes**
- Set up automatic builds: **No**

### Step 4: Deploy
```bash
firebase deploy --only hosting
```

Your app will be at: `https://YOUR_PROJECT_ID.web.app`

---

## Deploy to Netlify (Free Tier)

### Option 1: Drag & Drop (Easiest)
1. Go to https://app.netlify.com/drop
2. Drag the `docs` folder and drop it
3. Your site is live instantly!

### Option 2: Using Netlify CLI
```bash
npm install -g netlify-cli
netlify login
netlify deploy --prod --dir=docs
```

---

## Deploy to Vercel (Free Tier)

### Using Vercel CLI
```bash
npm install -g vercel
vercel login
cd docs
vercel --prod
```

---

## Live App URL

Once deployed, your app will be accessible at:

**Placeholder for your live URL:**
```
🌐 https://YOUR_DEPLOYMENT_URL
```

Replace with your actual URL after deployment.

---

## 📝 Notes

- The app is built as a **Progressive Web App (PWA)**
- It works offline after first load
- Can be "installed" on mobile devices
- All data is stored locally in the browser

## 🔒 Privacy

- No data leaves your device
- No accounts required
- No tracking
- Fully functional offline

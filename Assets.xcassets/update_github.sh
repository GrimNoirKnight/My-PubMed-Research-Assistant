#!/bin/bash
# update_github.sh version 0.0.10
echo "---------------------  Running update_github.sh version 0.0.10  --------------------- "

# Set the path to your repository (modify as needed)
REPO_PATH="$HOME/Documents/My PubMed Research Assistant"

# Check if the repository exists
if [ ! -d "$REPO_PATH/.git" ]; then
    echo "❌ Error: Repository not found at $REPO_PATH"
    exit 1
fi

# Change to the repository directory
cd "$REPO_PATH" || { echo "❌ Failed to access repository"; exit 1; }

# --- Rebase Cleanup ---
if git rev-parse --verify REBASE_HEAD > /dev/null 2>&1 || [ -d ".git/rebase-apply" ] || [ -d ".git/rebase-merge" ]; then
    echo "⚠️ Rebase metadata detected. Aborting any in-progress rebase..."
    git rebase --abort 2>/dev/null
    rm -rf .git/rebase-apply .git/rebase-merge .git/REBASE_HEAD 2>/dev/null
fi

# --- Remove .DS_Store Files ---
echo "🧹 Removing .DS_Store files..."
find . -name ".DS_Store" -delete

# --- Update .gitignore for .DS_Store ---
if ! grep -qxF ".DS_Store" .gitignore; then
    echo ".DS_Store" >> .gitignore
    git add .gitignore
    git commit -m "Add .DS_Store to .gitignore"
fi

# --- Clean Ignored Files ---
echo "🧹 Cleaning ignored files..."
git clean -fdX

# --- Stage and Commit Changes ---
echo "📂 Staging changes..."
git add .

echo -n "✏️  Enter commit message: "
read commit_msg
if [ -z "$commit_msg" ]; then
    echo "❌ Commit message cannot be empty."
    exit 1
fi

echo "📌 Committing changes..."
git commit -m "$commit_msg"

# --- Update Local History ---
echo "🔄 Pulling latest changes from GitHub with rebase..."
git pull origin main --rebase || { echo "❌ Git pull failed! Resolve conflicts and try again."; exit 1; }

# --- Push to GitHub ---
echo "🚀 Pushing changes to GitHub..."
git push origin main || { echo "❌ Git push failed! Resolve conflicts and try again."; exit 1; }

echo "✅ GitHub update completed successfully!"

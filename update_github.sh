#!/bin/bash
# update_github.sh 0.0.7

# Set the path to your repository (Modify this to match your actual repo path)
REPO_PATH="$HOME/Documents/My PubMed Research Assistant"

# Check if the repository exists
if [ ! -d "$REPO_PATH/.git" ]; then
    echo "❌ Error: Repository not found at $REPO_PATH"
    exit 1
fi

# Change to the repository directory
cd "$REPO_PATH" || { echo "❌ Failed to access repository"; exit 1; }

# --- Debug: List any rebase-related indicators ---
echo "🔍 Debug: Looking for rebase-related files/directories in .git:"
find .git -maxdepth 2 | grep -i rebase

# New rebase check: if a rebase is active, this command will succeed.
if git rebase --show-current-patch > /dev/null 2>&1; then
    echo "❌ Rebase in progress. Please finish or abort the rebase before running the script."
    exit 1
fi

# Ensure you’re on the main branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" != "main" ]; then
    echo "❌ Not on 'main' branch. Please switch to 'main' and try again."
    exit 1
fi

# Remove .DS_Store files before staging changes
echo "🧹 Removing .DS_Store files..."
find . -name ".DS_Store" -delete

# Add .DS_Store to .gitignore if it's not already ignored
if ! grep -qxF ".DS_Store" .gitignore; then
    echo ".DS_Store" >> .gitignore
    git add .gitignore
    git commit -m "Added .DS_Store to .gitignore"
fi

# Display current Git status
echo "🔍 Checking repository status..."
git status

# Prompt user for a commit message and validate it isn’t empty
echo -n "✏️  Enter commit message: "
read commit_msg
if [ -z "$commit_msg" ]; then
    echo "❌ Commit message cannot be empty."
    exit 1
fi

# Stage all changes (including deletions)
echo "📂 Staging changes..."
git add -A

# Commit changes
echo "📌 Committing changes..."
git commit -m "$commit_msg"

# Pull latest changes from GitHub with rebase
echo "🔄 Pulling latest changes from GitHub..."
git pull origin main --rebase || { echo "❌ Git pull failed! Resolve conflicts and try again."; exit 1; }

# Push changes to GitHub
echo "🚀 Pushing changes to GitHub..."
git push origin main || { echo "❌ Git push failed! Resolve conflicts and try again."; exit 1; }

# Confirm completion
echo "✅ GitHub update completed successfully!"

#!/bin/bash
set -euo pipefail

# create-bot-repo.sh - Create a new bot repository on GitHub
# Usage: ./create-bot-repo.sh <bot-name> <description>

BOT_NAME="${1:-}"
DESCRIPTION="${2:-A new OpenClaw bot}"

if [ -z "$BOT_NAME" ]; then
    echo "Usage: $0 <bot-name> [description]"
    echo "Example: $0 salesbot 'Sales analytics and forecasting bot'"
    exit 1
fi

echo "🤖 Creating GitHub repository: $BOT_NAME"
echo "📝 Description: $DESCRIPTION"
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI not found. Install with: brew install gh"
    exit 1
fi

# Create repository
REPO_URL=$(gh repo create "$BOT_NAME" \
    --public \
    --description "$DESCRIPTION" \
    --clone=false)

echo "✅ Repository created: $REPO_URL"
echo ""

# Clone to temp directory and set up initial structure
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
git clone "$REPO_URL" "$BOT_NAME"
cd "$BOT_NAME"

# Create basic structure from template
cp -r "$(dirname "$0")/../templates/basic-bot/"* .

# Customize with bot name
sed -i "" "s/\${BOT_NAME}/$BOT_NAME/g" README.md SOUL.md IDENTITY.md

# Initial commit
git add -A
git commit -m "Initial bot workspace setup

- SOUL.md: Bot persona and purpose
- USER.md: Relationships and access
- IDENTITY.md: Basic identity
- AGENTS.md: Operating principles
- TOOLS.md: Tools and connections
- MEMORY.md: Long-term memory
- README.md: Documentation
- .gitignore: Security exclusions"

git push origin main

# Clean up
cd -
rm -rf "$TEMP_DIR"

echo ""
echo "✅ Bot repository initialized!"
echo ""
echo "📋 Next steps:"
echo "  1. ./scripts/deploy-bot.sh $BOT_NAME $REPO_URL"
echo "  2. Customize the workspace for your bot's specific purpose"
echo "  3. Configure credentials and launch"
echo ""

#!/bin/bash
set -euo pipefail

# deploy-bot.sh - Deploy a new OpenClaw bot instance
# Usage: ./deploy-bot.sh <bot-name> <github-repo-url>

BOT_NAME="${1:-}"
REPO_URL="${2:-}"

if [ -z "$BOT_NAME" ] || [ -z "$REPO_URL" ]; then
    echo "Usage: $0 <bot-name> <github-repo-url>"
    echo "Example: $0 elibot https://github.com/ekranefuss/elibot-analytics.git"
    exit 1
fi

WORKSPACE_DIR="$HOME/.openclaw/workspace-$BOT_NAME"

echo "🤖 Deploying $BOT_NAME..."
echo "📦 Repository: $REPO_URL"
echo "📁 Workspace: $WORKSPACE_DIR"
echo ""

# Check if OpenClaw is installed
if ! command -v openclaw &> /dev/null; then
    echo "❌ OpenClaw not found. Install with: npm install -g openclaw"
    exit 1
fi

# Clone repository
if [ -d "$WORKSPACE_DIR" ]; then
    echo "⚠️  Workspace already exists: $WORKSPACE_DIR"
    read -p "Delete and re-clone? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$WORKSPACE_DIR"
    else
        echo "❌ Deployment cancelled"
        exit 1
    fi
fi

echo "📥 Cloning repository..."
git clone "$REPO_URL" "$WORKSPACE_DIR"
cd "$WORKSPACE_DIR"

# Create necessary directories
echo "📂 Creating directories..."
mkdir -p memory queries scripts

# Check for .env.template and create .env if needed
if [ -f ".env.template" ]; then
    if [ ! -f ".env" ]; then
        echo "📝 Creating .env from template..."
        cp .env.template .env
        echo "⚠️  Edit .env and add required credentials"
    fi
fi

# Initialize memory
echo "📝 Initializing memory..."
TODAY=$(date +%Y-%m-%d)
if [ ! -f "memory/$TODAY.md" ]; then
    cat > "memory/$TODAY.md" << EOF
# $TODAY - Deployment Day

## Deployed
- Bot deployed to $WORKSPACE_DIR
- Initial setup complete
- Ready for configuration

## Next Steps
- Configure .env with credentials
- Test basic functionality
- Connect communication channels
EOF
fi

echo ""
echo "✅ Bot deployed successfully!"
echo ""
echo "📋 Next steps:"
echo "  1. cd $WORKSPACE_DIR"
echo "  2. Edit .env with required credentials"
echo "  3. Test: openclaw --workspace=$WORKSPACE_DIR chat"
echo "  4. Configure gateway: openclaw config"
echo "  5. Start: openclaw gateway start"
echo ""

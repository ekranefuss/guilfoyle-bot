#!/bin/bash
set -euo pipefail

# push-global-soul.sh - Push Matt's Voice to all employee bot repositories
# Usage: ./push-global-soul.sh

SOURCE_FILE="templates/shared/MATTS_VOICE.md"
EMPLOYEE_BOTS=(
    "elibot-analytics"
    # Add more employee bots here as they're created
)

echo "📢 Pushing Matt's Voice to employee bots..."
echo ""

if [ ! -f "$SOURCE_FILE" ]; then
    echo "❌ Source file not found: $SOURCE_FILE"
    exit 1
fi

TEMP_DIR=$(mktemp -d)

for bot in "${EMPLOYEE_BOTS[@]}"; do
    echo "🤖 Updating $bot..."
    
    # Clone the bot repository
    REPO_URL="https://github.com/ekranefuss/$bot.git"
    cd "$TEMP_DIR"
    
    if git clone "$REPO_URL" "$bot" 2>/dev/null; then
        cd "$bot"
        
        # Copy the global voice file
        cp "$OLDPWD/$SOURCE_FILE" ./MATTS_VOICE.md
        
        # Commit and push
        git add MATTS_VOICE.md
        
        if git diff --staged --quiet; then
            echo "   ✅ Already up to date"
        else
            git commit -m "Update Matt's Voice (pushed by Guilfoyle)

Global voice and tone guidelines updated from master template."
            git push origin main
            echo "   ✅ Updated successfully"
        fi
        
        cd ..
    else
        echo "   ⚠️  Failed to clone $REPO_URL"
    fi
    
    echo ""
done

# Clean up
rm -rf "$TEMP_DIR"

echo "✅ Global voice push complete!"
echo ""
echo "📋 Updated bots:"
for bot in "${EMPLOYEE_BOTS[@]}"; do
    echo "  - $bot"
done

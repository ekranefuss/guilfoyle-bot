#!/bin/bash
set -euo pipefail

# status-all.sh - Check status of all deployed bots

echo "🤖 Bot Fleet Status"
echo "===================="
echo ""

# Find all OpenClaw workspaces
for workspace in "$HOME/.openclaw/workspace"*; do
    if [ -d "$workspace" ]; then
        bot_name=$(basename "$workspace" | sed 's/workspace-//;s/workspace/mattbot/')
        
        echo "📦 $bot_name"
        echo "   Workspace: $workspace"
        
        # Check if SOUL.md exists (valid bot workspace)
        if [ -f "$workspace/SOUL.md" ]; then
            echo "   ✅ Valid workspace"
            
            # Check last commit
            if [ -d "$workspace/.git" ]; then
                last_commit=$(cd "$workspace" && git log -1 --format="%cr" 2>/dev/null || echo "unknown")
                echo "   📅 Last update: $last_commit"
            fi
            
            # Check if gateway is running (placeholder - would need actual check)
            # echo "   🟢 Gateway: running"
        else
            echo "   ⚠️  Not a valid bot workspace"
        fi
        
        echo ""
    fi
done

echo "===================="
echo ""
echo "💡 Tip: Use 'openclaw gateway status' to check if gateways are running"

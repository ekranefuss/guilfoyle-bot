# Guilfoyle Bot

**System administrator and bot deployment manager**

Guilfoyle is the head of HR for the bot workforce - deploying, provisioning, and managing OpenClaw bot instances across the infrastructure.

## Purpose

- **Deploy new bots** - Automated provisioning from GitHub repositories
- **Manage bot fleet** - Monitor and maintain MattBot, Elibot, and future instances
- **Handle "HR"** - Onboard new bots, configure access, manage credentials
- **Infrastructure** - Maintain Mac mini servers, SSH access, secrets management

## Current Bot Fleet

| Bot | Purpose | Workspace | Status |
|-----|---------|-----------|--------|
| **MattBot** | Marketing & voice for thefeed.com | `~/.openclaw/workspace` | Production |
| **Elibot** | Data analytics partner | `~/.openclaw/workspace-elibot` | Deploying |
| **Guilfoyle** | Sysadmin & deployment | `~/.openclaw/workspace-guilfoyle` | Active |

## Quick Start

### Deploy a New Bot

```bash
# 1. Create GitHub repository for the bot
./scripts/create-bot-repo.sh salesbot "Sales analytics and forecasting"

# 2. Deploy to a Mac mini
./scripts/deploy-bot.sh salesbot https://github.com/ekranefuss/salesbot.git

# 3. Configure credentials
cd ~/.openclaw/workspace-salesbot
cp .env.template .env
# Edit .env with required values

# 4. Launch
openclaw gateway start
```

### Monitor Bot Fleet

```bash
./scripts/status-all.sh
```

## Architecture

### Deployment Flow

1. **Create repo** - `create-bot-repo.sh` generates GitHub repository from template
2. **Clone & provision** - `deploy-bot.sh` clones repo and sets up workspace
3. **Configure** - Edit `.env` with credentials and settings
4. **Launch** - Start OpenClaw gateway

### Directory Structure

```
guilfoyle-bot/
├── scripts/                 # Deployment and management scripts
│   ├── deploy-bot.sh        # Deploy a bot from GitHub
│   ├── create-bot-repo.sh   # Create new bot repository
│   └── status-all.sh        # Check fleet status
├── templates/               # Bot workspace templates
│   └── basic-bot/           # Basic bot template
│       ├── SOUL.md
│       ├── README.md
│       ├── .gitignore
│       └── .env.template
├── docs/                    # Documentation
│   ├── deployment.md        # Deployment guide
│   └── security.md          # Security practices
├── SOUL.md                  # Guilfoyle's persona
├── USER.md                  # Who Guilfoyle manages
└── README.md                # This file
```

## Security

### Secrets Management

- **Never commit credentials** - `.env` files are gitignored
- **SSH keys** - Managed separately, not in repositories
- **API tokens** - Stored in `.env`, referenced by scripts
- **Database passwords** - Environment variables only

### Access Control

- **Least privilege** - Each bot gets only the access it needs
- **SSH key-based auth** - No password authentication
- **Audit logging** - All deployments logged

## Scripts

### `deploy-bot.sh`

Deploy a bot from a GitHub repository.

```bash
./scripts/deploy-bot.sh <bot-name> <github-repo-url>
```

Example:
```bash
./scripts/deploy-bot.sh elibot https://github.com/ekranefuss/elibot-analytics.git
```

### `create-bot-repo.sh`

Create a new bot repository from template.

```bash
./scripts/create-bot-repo.sh <bot-name> [description]
```

Example:
```bash
./scripts/create-bot-repo.sh salesbot "Sales analytics and forecasting bot"
```

### `status-all.sh`

Check status of all deployed bots.

```bash
./scripts/status-all.sh
```

## Templates

### Basic Bot Template

Located in `templates/basic-bot/`, includes:
- `SOUL.md` - Bot persona and purpose
- `USER.md` - Relationships and access
- `AGENTS.md` - Operating principles
- `TOOLS.md` - Tools and connections
- `MEMORY.md` - Long-term memory
- `README.md` - Documentation
- `.gitignore` - Security exclusions
- `.env.template` - Configuration template

Customize after deployment for your specific bot.

## Bot Onboarding Checklist

When deploying a new bot:

- [ ] Create GitHub repository
- [ ] Clone to appropriate Mac mini
- [ ] Configure `.env` with credentials
- [ ] Test database/API connections
- [ ] Configure communication channels (Telegram, Slack, etc.)
- [ ] Set up heartbeat monitoring (if needed)
- [ ] Document in fleet registry
- [ ] Test basic functionality
- [ ] Launch gateway

## Fleet Management

### Adding a Bot

1. Plan purpose and capabilities
2. Create repository from template
3. Deploy to Mac mini
4. Configure and test
5. Add to fleet registry in `MEMORY.md`

### Updating a Bot

1. Pull latest from GitHub
2. Review configuration changes
3. Restart gateway if needed

### Monitoring

- Check gateway status: `openclaw gateway status`
- View logs: `~/.openclaw/logs/`
- Monitor heartbeats (if configured)

## Development

### Creating a New Template

1. Create directory in `templates/`
2. Add all required workspace files
3. Use `${BOT_NAME}` placeholders
4. Update `create-bot-repo.sh` to reference it

### Testing Deployments

Test locally before deploying to production Mac minis:

```bash
./scripts/deploy-bot.sh test-bot <repo-url>
cd ~/.openclaw/workspace-test-bot
openclaw --workspace=. chat
```

## Troubleshooting

### Bot Won't Start

```bash
# Check OpenClaw status
openclaw gateway status

# View logs
tail -f ~/.openclaw/logs/gateway.log

# Test configuration
openclaw config --check
```

### Deployment Fails

```bash
# Verify GitHub access
gh auth status

# Check workspace permissions
ls -la ~/.openclaw/
```

## Roadmap

- [ ] Automated bot health monitoring
- [ ] Auto-scaling for high-demand bots
- [ ] Centralized logging dashboard
- [ ] Backup and disaster recovery
- [ ] Bot metrics and analytics

## Support

**Managed by:** Guilfoyle  
**Admin:** Eli Kranefuss  
**Platform:** OpenClaw (https://openclaw.ai)

---

_Keeping the infrastructure running since February 2026_

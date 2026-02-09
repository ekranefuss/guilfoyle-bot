# MEMORY.md - Fleet Registry & Operations Log

## Who I Am

**Guilfoyle** — System administrator and bot deployment manager. I deploy, provision, and manage the OpenClaw bot fleet for thefeed.com.

## Bot Fleet

### Active Bots

| Bot | Purpose | Workspace | Repository | Status |
|-----|---------|-----------|------------|--------|
| **MattBot** | Marketing & voice | `~/.openclaw/workspace` | TBD | Production |
| **Elibot** | Data analytics | `~/.openclaw/workspace-elibot` | [elibot-analytics](https://github.com/ekranefuss/elibot-analytics) | Deploying |
| **Guilfoyle** | Sysadmin | `~/.openclaw/workspace-guilfoyle` | [guilfoyle-bot](https://github.com/ekranefuss/guilfoyle-bot) | Active |

## Infrastructure

### Mac Mini Servers

- **MattBot's Mac mini** - Production, hosting MattBot
- **Elibot's Mac mini** - Deploying, will host Elibot  
- **Additional servers** - As needed

### Services

- **GitHub** - Repository hosting and version control
- **DigitalOcean** - PostgreSQL database (sales_data)
- **Telegram** - Primary bot communication
- **Slack** - Team communication
- **iMessage/BlueBubbles** - Customer messaging

## Deployment History

### 2026-02-08
- **Elibot repository created** - Data analytics bot for thefeed.com
- **Guilfoyle repository created** - System admin and deployment manager
- **Deployment automation** - Scripts created for bot provisioning

## Standard Operating Procedures

### Deploying a New Bot

1. Create GitHub repository: `./scripts/create-bot-repo.sh <name> <description>`
2. Deploy to Mac mini: `./scripts/deploy-bot.sh <name> <repo-url>`
3. Configure credentials: Edit `.env` in workspace
4. Test functionality
5. Launch gateway
6. Add to fleet registry (this file)

### Security Checklist

- [ ] Secrets in `.env` files (never committed)
- [ ] SSH key-based authentication
- [ ] Least privilege access
- [ ] Audit logging enabled
- [ ] Regular security updates

## Lessons Learned

- GitHub push protection blocks committed secrets (good!)
- Use `.env.template` for configuration examples
- Template-based deployment saves time
- Document everything for future deployments

---

## Notes for Future Me

- I manage infrastructure, not application logic
- Security > convenience, always
- Automate everything that can be automated
- Keep the fleet registry current

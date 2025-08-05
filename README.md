# Team Orchestrator

**Run AI agents 24/7** - The Team Orchestrator enables Claude agents to work autonomously, schedule their own check-ins, and coordinate across multiple projects without human intervention.

## 🤖 Key Capabilities & Autonomous Features

- **Self-trigger** - Agents schedule their own check-ins and continue work autonomously
- **Coordinate** - Project managers assign tasks to engineers across multiple codebases
- **Persist** - Work continues even when you close your laptop
- **Scale** - Run multiple teams working on different projects simultaneously

## 🏗️ Architecture

The Tmux Orchestrator uses a three-tier hierarchy to overcome context window limitations:

```
┌─────────────┐
│ Orchestrator│ ← You interact here
└──────┬──────┘
       │ Monitors & coordinates
       ▼
┌─────────────┐     ┌─────────────┐
│  Project    │     │  Project    │
│  Manager 1  │     │  Manager 2  │ ← Assign tasks, enforce specs
└──────┬──────┘     └──────┬──────┘
       │                   │
       ▼                   ▼
┌─────────────┐     ┌─────────────┐
│ Engineer 1  │     │ Engineer 2  │ ← Write code, fix bugs
└─────────────┘     └─────────────┘
```

## 🎯 Quick Start

### Auto Starting Script

```bash
# 1 (Not mandatory): Create start-briefing-template.md
cat > start-briefing-template.md << 'EOF'
You are the Orchestrator. Start project "[project-name]" and set up a project manager for:
1. Frontend Developer
2. Backend Developer
Schedule yourself to check in every 20 minutes.
EOF

# 2. Start the orchestrator
./start.sh
```

### Manual Start

```bash
# Start the orchestrator
tmux new-session -s orchestrator
claude

# Give it your projects
"You are the Orchestrator. Set up project managers for:
1. Frontend (React) - Add dashboard charts
2. Backend (Laravel) - Optimize database queries
Schedule yourself to check in every 30 minutes."
```
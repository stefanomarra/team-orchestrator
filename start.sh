#!/usr/bin/env bash

# === GENERIC ORCHESTRATOR STARTUP ===
# Simple 3-step orchestrator startup with briefing template

set -e

ORCHESTRATOR_SESSION="orchestrator"
BRIEFING_TEMPLATE="start-briefing-template.md"

# === LOGGING FUNCTIONS ===
log_info() { echo "ℹ️  $1"; }
log_success() { echo "✅ $1"; }
log_error() { echo "❌ $1" >&2; }
log_warning() { echo "⚠️  $1" >&2; }

# Check if session already exists
if tmux has-session -t "$ORCHESTRATOR_SESSION" 2>/dev/null; then
    log_error "Session '$ORCHESTRATOR_SESSION' already exists"
    log_info "Attach with: tmux attach -t $ORCHESTRATOR_SESSION"
    log_info "Or kill it with: tmux kill-session -t $ORCHESTRATOR_SESSION"
    exit 1
fi

log_info "🚀 Starting Team Orchestrator"

# Step 1: Create orchestrator session
log_info "Creating orchestrator tmux session: $ORCHESTRATOR_SESSION"
tmux new-session -d -s "$ORCHESTRATOR_SESSION"
log_success "Created orchestrator session"

# Step 2: Start Claude in the orchestrator
log_info "Starting Claude in orchestrator session"
tmux send-keys -t "$ORCHESTRATOR_SESSION:0" "claude" Enter

# Wait for Claude to initialize
log_info "Waiting for Claude to initialize..."
sleep 5

# Step 3: Prepare briefing from template file (but don't send it)
log_info "Preparing briefing for orchestrator"
if [[ -f "$BRIEFING_TEMPLATE" ]]; then
    BRIEFING_CONTENT=$(cat "$BRIEFING_TEMPLATE")

    # Type the briefing but don't press Enter - let user review/edit
    tmux send-keys -t "$ORCHESTRATOR_SESSION:0" "$BRIEFING_CONTENT"

    log_success "Briefing prepared - ready to review and send"
else
    log_warning "No briefing template found at: $BRIEFING_TEMPLATE"
fi

# Step 4: Attach to the session
log_success "Orchestrator initialization complete!"
log_info "Attaching to session..."
log_info "To detach later: Ctrl+b + d"
log_info "To reattach: tmux attach -t $ORCHESTRATOR_SESSION"

tmux attach -t "$ORCHESTRATOR_SESSION"
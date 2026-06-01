#!/bin/bash
# Install script Bash pentru Legal Toolkit Bundle
# Compatibil: macOS, Linux, Windows (Git Bash sau WSL)

set -e
BUNDLE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Legal Toolkit Bundle Installer"
echo "Sursa: $BUNDLE_ROOT"
echo ""

# Detectare medii Claude
if [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* ]]; then
    CLAUDE_CODE_DIR="$HOME/.claude"
    CLAUDE_DESKTOP_CONFIG="$APPDATA/Claude/claude_desktop_config.json"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    CLAUDE_CODE_DIR="$HOME/.claude"
    CLAUDE_DESKTOP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
else
    CLAUDE_CODE_DIR="$HOME/.claude"
    CLAUDE_DESKTOP_CONFIG="$HOME/.config/Claude/claude_desktop_config.json"
fi

HAS_CLAUDE_CODE=$([[ -d "$CLAUDE_CODE_DIR" ]] && echo "yes" || echo "no")
HAS_CLAUDE_DESKTOP=$([[ -f "$CLAUDE_DESKTOP_CONFIG" ]] && echo "yes" || echo "no")

echo "Claude Code detectat: $HAS_CLAUDE_CODE ($CLAUDE_CODE_DIR)"
echo "Claude Desktop detectat: $HAS_CLAUDE_DESKTOP ($CLAUDE_DESKTOP_CONFIG)"
echo ""

if [[ "$HAS_CLAUDE_CODE" == "no" && "$HAS_CLAUDE_DESKTOP" == "no" ]]; then
    echo "ERROR: Nu am detectat nici Claude Code nici Claude Desktop. Verifica instalarile."
    exit 1
fi

# Verificare Python
if ! command -v python &> /dev/null && ! command -v python3 &> /dev/null; then
    echo "ERROR: Python nu este instalat. Instaleaza Python 3.10 plus inainte."
    exit 1
fi

PYTHON=$(command -v python || command -v python3)
echo "Python detectat: $($PYTHON --version)"

# Verificare python-docx
if ! $PYTHON -c "import docx" 2>/dev/null; then
    echo "Instalez python-docx..."
    pip install python-docx --quiet
fi

echo ""

if [[ "$HAS_CLAUDE_CODE" == "yes" ]]; then
    echo "=== Instalare in Claude Code ($CLAUDE_CODE_DIR) ==="

    mkdir -p "$CLAUDE_CODE_DIR/skills" "$CLAUDE_CODE_DIR/agents" "$CLAUDE_CODE_DIR/scripts" "$CLAUDE_CODE_DIR/cowork-templates"

    cp -r "$BUNDLE_ROOT/skills/." "$CLAUDE_CODE_DIR/skills/"
    cp -r "$BUNDLE_ROOT/agents/." "$CLAUDE_CODE_DIR/agents/"
    cp -r "$BUNDLE_ROOT/scripts/." "$CLAUDE_CODE_DIR/scripts/"
    cp -r "$BUNDLE_ROOT/cowork-templates/." "$CLAUDE_CODE_DIR/cowork-templates/"

    echo "OK Componente copiate in Claude Code."
    echo ""
    echo "ATENTIE Claude Code: configureaza hook-urile in settings.json. Vezi README.md."
    echo ""
fi

if [[ "$HAS_CLAUDE_DESKTOP" == "yes" ]]; then
    echo "=== Instalare MCP anti-ai-tone in Claude Desktop ==="

    MCP_FILE="$BUNDLE_ROOT/mcp-servers/anti-ai-tone-v1.1.0.mcpb"
    if [[ -f "$MCP_FILE" ]]; then
        echo "Fisier MCPB gasit: $MCP_FILE"
        cp "$MCP_FILE" "$HOME/Downloads/" 2>/dev/null || cp "$MCP_FILE" "$HOME/" 2>/dev/null

        echo ""
        echo "INSTALARE MANUALA Claude Desktop:"
        echo "1. Deschide Claude Desktop"
        echo "2. Settings, Extensions, Browse"
        echo "3. Sau dublu-click pe $HOME/Downloads/anti-ai-tone-v1.1.0.mcpb"
        echo ""
    fi
fi

echo "=== Pasi manuali Claude Cowork ==="
echo "1. Deschide Claude.ai, Settings, Profile"
echo "2. Copy-paste din: $BUNDLE_ROOT/cowork-templates/PROJECT_INSTRUCTIONS_UNIVERSAL.md"
echo "3. Pentru fiecare Project juridic sau energetic, aplica template specific."
echo "4. Activeaza Citations API in Beta features."
echo ""

echo "=== Instalare completa ==="
echo "Pentru intrebari sau bug-uri, contact: popa.andrei.nicolae@gmail.com"

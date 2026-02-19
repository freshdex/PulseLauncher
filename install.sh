#!/bin/bash
# CCPL Installer — https://github.com/freshdex/ccpl
set -e

BOLD='\033[1m'
GREEN='\033[32m'
RED='\033[31m'
NC='\033[0m'

INSTALL_DIR="$HOME/.local/bin"
BIN_NAME="ccpl"

echo ""
echo -e "${BOLD}CCPL Installer${NC}"
echo ""

# --- Check WSL ---
if [ ! -f /proc/version ] || ! grep -qi microsoft /proc/version 2>/dev/null; then
    echo -e "${RED}Error:${NC} CCPL requires WSL (Windows Subsystem for Linux)."
    exit 1
fi

# --- Check dependencies ---
missing=()
for cmd in curl python3 node npm; do
    if ! command -v "$cmd" &>/dev/null; then
        missing+=("$cmd")
    fi
done

if [ ${#missing[@]} -gt 0 ]; then
    echo -e "${RED}Error:${NC} Missing required dependencies: ${missing[*]}"
    echo "Install them and re-run this script."
    exit 1
fi

echo -e "${GREEN}✓${NC} WSL detected"
echo -e "${GREEN}✓${NC} Dependencies satisfied"

# --- Download / copy script ---
mkdir -p "$INSTALL_DIR"

# If running from a local clone, copy the adjacent ccpl.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/ccpl.sh" ]; then
    cp "$SCRIPT_DIR/ccpl.sh" "$INSTALL_DIR/$BIN_NAME"
else
    curl -fsSL "https://raw.githubusercontent.com/freshdex/ccpl/main/ccpl.sh" \
        -o "$INSTALL_DIR/$BIN_NAME"
fi

chmod +x "$INSTALL_DIR/$BIN_NAME"
echo -e "${GREEN}✓${NC} Installed to $INSTALL_DIR/$BIN_NAME"

# --- Check PATH ---
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
    echo ""
    echo -e "  ${BOLD}Note:${NC} $INSTALL_DIR is not in your PATH."
    echo "  Add this to your ~/.bashrc or ~/.zshrc:"
    echo ""
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

echo ""
echo -e "${GREEN}Done!${NC} Run ${BOLD}ccpl${NC} to launch."
echo ""

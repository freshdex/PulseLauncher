#!/bin/bash
# CCPL Uninstaller — https://github.com/freshdex/ccpl
set -e

BOLD='\033[1m'
GREEN='\033[32m'
YELLOW='\033[33m'
NC='\033[0m'

INSTALL_DIR="$HOME/.local/bin"
BIN_NAME="ccpl"

echo ""
echo -e "${BOLD}CCPL Uninstaller${NC}"
echo ""

# --- Remove binary ---
if [ -f "$INSTALL_DIR/$BIN_NAME" ]; then
    rm "$INSTALL_DIR/$BIN_NAME"
    echo -e "${GREEN}✓${NC} Removed $INSTALL_DIR/$BIN_NAME"
else
    echo -e "${YELLOW}⚠${NC} $INSTALL_DIR/$BIN_NAME not found — skipped"
fi

echo ""
echo -e "${GREEN}Done!${NC} CCPL has been uninstalled."
echo ""

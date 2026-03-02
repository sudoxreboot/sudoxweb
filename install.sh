#!/bin/bash
PLASMOID_DIR="$HOME/.local/share/plasma/plasmoids"
ICON_DIR="$HOME/.local/share/icons/hicolor/512x512/apps"

mkdir -p "$PLASMOID_DIR" "$ICON_DIR"

cp -r sudox.web.viewer "$PLASMOID_DIR/"
cp -r sudox.steam.launcher "$PLASMOID_DIR/"
cp sudox.web.viewer.png "$ICON_DIR/sudox.web.viewer.png"
gtk-update-icon-cache "$HOME/.local/share/icons/hicolor/" 2>/dev/null || true

echo "done. restart plasmashell:"
echo "  kquitapp6 plasmashell && plasmashell > /dev/null 2>&1 &"

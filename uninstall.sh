#!/bin/bash
rm -rf "$HOME/.local/share/plasma/plasmoids/sudox.web.viewer"
rm -rf "$HOME/.local/share/plasma/plasmoids/sudox.steam.launcher"
rm -f "$HOME/.local/share/icons/hicolor/512x512/apps/sudox.web.viewer.png"
echo "done. restart plasmashell:"
echo "  kquitapp6 plasmashell && plasmashell > /dev/null 2>&1 &"

#!/usr/bin/env bash
# Setzt zentral das Plasma-Wallpaper für alle Desktops/Containments

WALL="/usr/share/wallpapers/lab.jpg"

if command -v plasma-apply-wallpaperimage >/dev/null 2>&1; then
  plasma-apply-wallpaperimage "$WALL"
  exit 0
fi

# Fallback für ältere Plasma-Installationen: per qdbus (best effort)
if command -v qdbus >/dev/null 2>&1; then
  SCRIPT="
  var Desktops = desktops();
  for (i=0;i<Desktops.length;i++) {
    d = Desktops[i];
    d.wallpaperPlugin = 'org.kde.image';
    d.currentConfigGroup = Array('Wallpaper','org.kde.image','General');
    d.writeConfig('Image', 'file://$WALL');
  }"
  qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "$SCRIPT" || true
fi

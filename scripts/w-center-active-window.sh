#!/bin/bash

# Requires a kdotool version with the kwinscript command (KDE Plasma 6).
if ! command -v kdotool >/dev/null 2>&1; then
    echo "Error: install kdotool with kwinscript support to center Wayland windows." >&2
    exit 1
fi

# Ask KWin for the active window's usable monitor area, including panel space
# and monitor offsets. Keep the window two-thirds wide and full height.
exec kdotool kwinscript --inline '
var win = workspace.activeWindow;
if (!win) {
    throw new Error("No active window to center.");
}
if (!win.moveable || !win.resizeable) {
    throw new Error("The active window cannot be moved or resized.");
}
var area = workspace.clientArea(KWin.MaximizeArea, win);
if (!(area.width > 0 && area.height > 0)) {
    throw new Error("Could not determine the usable monitor area.");
}
win.fullScreen = false;
win.setMaximize(false, false);
var width = Math.round(area.width * 2 / 3);
win.frameGeometry = {
    x: area.x + Math.round((area.width - width) / 2),
    y: area.y,
    width: width,
    height: area.height
};
output_result("Centered active window.");
'

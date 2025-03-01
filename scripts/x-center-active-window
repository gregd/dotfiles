#!/bin/bash

# https://askubuntu.com/questions/104155/center-a-window-via-command-line/571711#571711

IFS='x' read screenWidth screenHeight < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)

newPosX=$((screenWidth / 6))
newWidth=$((screenWidth - screenWidth / 3))
newHeight=$((screenHeight - 50))

echo $screenWidth x $screenHeight
echo $newPosX , $newWidth

wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
wmctrl -r :ACTIVE: -e 0,$newPosX,0,$newWidth,$newHeight
wmctrl -r :ACTIVE: -b add,maximized_vert

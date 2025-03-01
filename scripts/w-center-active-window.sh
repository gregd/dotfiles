#!/bin/bash

# Get screen geometry from kscreen-doctor
output_info=$(kscreen-doctor -o)
geometry_line=$(echo "$output_info" | grep "Geometry:")
resolution=$(echo "$geometry_line" | grep -o '[0-9]*,[0-9]* [0-9]*x[0-9]*' | head -n1)
IFS=' ' read position resolution_str <<< "$resolution"
IFS='x' read screenWidth screenHeight <<< "$resolution_str"

# Calculate window size and position
newPosX=$(((screenWidth / 6) + 48))
newWidth=$((screenWidth - screenWidth / 3))
newHeight=$screenHeight

echo "Screen resolution: $screenWidth x $screenHeight"
echo "New position: $newPosX, New width: $newWidth, New height: $newHeight"

# Use kdotool to resize and position the window
kdotool getactivewindow windowmove $newPosX 0
kdotool getactivewindow windowsize $newWidth $newHeight

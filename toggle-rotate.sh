#!/bin/bash

# This script relies on the presence of xrandr (primitive command line interface to RandR extension) on your system and on its implementation for gnome desktop using Wayland as the windowing system, provided at https://github.com/rickybrent/gnome-randr-py

# Check for required commands
if ! command -v xrandr &> /dev/null; then
    exit 1
fi

if ! command -v gnome-randr.py &> /dev/null; then
    exit 1
fi

# Variables (You need to set these).
screen="YOUR_SCREEN_NAME"
rotate="desired_rotation" # "inverted" will flip your screen 180º

# Get the current session type
session="${XDG_SESSION_TYPE:-$(loginctl show-session "$(loginctl | grep -o '^[0-9]*' | head -n1)" -p Type --value)}"

if [ "$session" == "wayland" ]; then
    # Get a list of monitors to check if there's only one
    monitors=$(xrandr --listactivemonitors | grep "^Monitors")
    if [ "$monitors" == "Monitors: 1" ]; then
        rotation=$(gnome-randr.py | grep "normal")

        # Determine the rotation
        if [ -n "$rotation" ]; then
            rotate="$rotate"
        else
            rotate="normal"
        fi

	# Apply the rotation using gnome-randr.py
        gnome-randr.py --output "$screen" --rotate "$rotate"
    fi

elif [ "$session" == "x11" ]; then
    # Get the output of xrandr and filter the lines that start with the screen name
    matchline=$(xrandr | grep "^$screen")

    # Split the matchline into an array
    read -a matchline_array <<< "$matchline"

    # Find the index of the element with two '+' signs
    for i in "${!matchline_array[@]}"; do
        if [[ "${matchline_array[$i]}" == *"+"* ]] && [[ "${matchline_array[$i]}" == *"+"* ]]; then
            index=$((i+1))
            break
        fi
    done

    # Get the element at that index
    s="${matchline_array[$index]}"

    # Determine the rotation
    if [ "$s" != "$rotate" ]; then
        rotate="$rotate"
    else
        rotate="normal"
    fi

    # Apply the rotation using xrandr
    xrandr --output "$screen" --rotate "$rotate"
else
    exit 1
fi


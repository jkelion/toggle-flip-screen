# toggle-flip-screen
Bash script to rotate screen display with either Wayland or X11 windowing systems.

The script is intended for Ubuntu users on a laptop that has a screen hinged in away that enables it to face a person sitting opposite (lie flat or bend further).

When showing the person opposite the computer what is on ones screen, the display needs to be flipped so that it faces the other person. Toggling the display of the screen can be achieved by linking this script to a keyboard shortcut.

This toggle-rotate.sh bash script and the gnome-randr.py python script, provided at https://github.com/rickybrent/gnome-randr-py, need to be copied, say to ~/.local/bin\
The toggle-rotate.sh script can then be bound to the keyboard key with a custom shortcut.

The toggle-rotate.sh script was inspired by an answer provided by Jacob Vlijm here https://askubuntu.com/a/737155

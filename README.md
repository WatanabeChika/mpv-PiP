# mpv Picture-in-Picture (PiP)

This script adds Picture-in-Picture functionality to MPV media player, allowing you to watch videos in a small floating window while working with other applications. It is tested only on Windows system.

## Features

- Toggle Picture-in-Picture mode with a single keypress.
- Borderless floating window that stays on top of other applications.
- Automatically exits PiP mode when entering fullscreen.

## Installation

1. Ensure you have [MPV Media Player](https://mpv.io/) installed on your system.
2. Copy the `mpv-PiP.lua` script into your MPV scripts directory, e.g.:
   - `C:\Users\<YourUsername>\AppData\Roaming\mpv\scripts\`
3. Restart MPV.

## Usage

Press **`Alt+P`** to toggle Picture-in-Picture mode on/off. Then you can use the mouse to freely resize the window and adjust its position.

### Automatic Behavior

- Entering fullscreen while in PiP mode will automatically disable PiP and enter fullscreen normally.
- The script handles file transitions properly - PiP mode persists when loading new videos.
- Original window settings are preserved even when MPV saves state via *watchlater* when `save-position-on-quit` is true.

## Acknowledgments

- Original script by [Wanakachi](https://github.com/WatanabeChika).

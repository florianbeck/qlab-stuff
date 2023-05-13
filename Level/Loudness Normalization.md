## Introduction
Loudness Normalization of Audiocues in Accordance with EBU R 128 adjusting the Master Volume.

## Requirements
The Loudness Normalization script requires a external CLI tool for the loundess measurement. The tool is called [r128x](https://github.com/audionuma/r128x) by Audionuma.

## Installation
You can download a compiled version of r128x-cli from the [Github Repository](https://github.com/audionuma/r128x/releases/latest).

To use it, you install the file called `r128x-cli` into the folder `/usr/local/bin`.

Once you’ve installed r128x-cli into the /bin folder, right-click (or two-finger-click, or control-click) on it, mouse over to the Open with… submenu, and choose Terminal. You’ll be presented with a warning; do you really want to do this? Answer yes, you do. It will open a window in Terminal.app and run itself. Once that’s done, which will be more or less immediate, simply quit Terminal. After you do this once, your Mac will regard this file as safe to run.

## User defined variables
- `theReferenceLevel` set the desired LUFS reference level
- `theFaderLevel` set the master fader level to your preferred output level for cues with an LUFS at the reference level

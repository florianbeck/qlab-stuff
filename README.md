# Qlab Stuff

[![GitHub license](https://img.shields.io/github/license/florianbeck/qlab-stuff.svg)](https://github.com/florianbeck/qlab-stuff/blob/main/LICENSE)

## Introduction

This is a collection of scripts for Figure 53's **Qlab** show control software.

## Installation

To install the scripts as script cues, use the script "~/00 Import scripts to cues.applescript". Run the script from Script Editor with your qlab file open, and it will allow you to select the script or scripts you wish to import. If you import multiple scripts, it will create script cues and write the scripts (with less header information) into the cue. If you import a single script and currently have a script cue selected, it will write the script into that cue.

<!-- ### Script Library

To install the scripts to your user's Library folder, in "Script Libraries", run the script "~/00 Import all to library.applescript" from the script editor. This gives you two options: install from a local folder (if you have downloaded a specific release, to work with a Qlab file you have already set up) or directly from github (if you have an internet connection and want the most up to date versions).

Within Qlab, call the script (usually from within a `tell application "Qlab" to tell front workspace` block) like so:

`tell script "Mixing Desk Programming/Choose Desk to program" to run` -->

<!--## User Defined Variables

Some scripts contain User Defined Variables. With these, when you call the script within Qlab, you can declare these variables globally and set them from within Qlab: e.g. in `Levels/Loudness Normalization` you can set the reference and fader level. The syntax for this would be as follows:

```applescript
global theReferenceLevel, thefaderLevel
set theReferenceLevel to -23
set thefaderLevel to 0
```-->

<!-- ## Variables set within Qlab

Many of these variables will stay the same for your template from show to show - some others depend on the design. These are set from within Qlab, as the notes of a cue.

Using the example `Levels/Bump level`, the variables from Qlab are `audioChannelCount` and `minAudioLevel`.

To set these variables, you must set as a User Defined Variable `variableCueListName`. This is the cue list that you have stored your notes cues in. I recommend using Memo cues. In this instance, you would name one cue `Output channel count` and the other `Min audio level`. You do not need numbers for those cues.

The total list of Qlab Note variables required for the entire script library is:
- Output channel count
- Min audio level
- Output channel names [this should simply be a list separated by ", "]
- Line Checks: output level [my default is -12]
- Line Checks: sub level [my default is -12] -->

## Tags

- `@description` Name of the script
- `@author` Most recent author of the script
- `@link` Link to the author's website
- `@source` Where scripts are taken from another source, or adapted from one, that author is listed here
- `@version` Version of the script
- `@testedmacos` The most recent version of MacOS that the script has been tested on
- `@testedqlab` The most recent version of Qlab that the script has been tested on
- `@about` A description of the script
- `@separateprocess` TRUE or FALSE, whether the script needs to run in a separate process within Qlab
- `@changelog` Changes for this version of the script

## Credits
The general idea for the structure of QLab scripts and how to deal with them is adopted of Ben Smiths [QLab Scripts](https://github.com/bsmith96/Qlab-Scripts).

In all scripts that are adapted from publicly available versions, the original author is credited in the `@source` tag, in the header of the file.
# Qlab Stuff

[![GitHub license](https://img.shields.io/github/license/florianbeck/qlab-stuff.svg)](https://github.com/florianbeck/qlab-stuff/blob/main/LICENSE)

## Introduction

This is a collection of scripts for Figure 53's **Qlab** show control software.

## Installation

These scripts can either run within Qlab as script cues, though I recommend that instead, the be called from script cues and run externally.

To install the scripts as script cues, use the script "~/00 Import scripts to cues.applescript". Run the script from Script Editor with your qlab file open, and it will allow you to select the script or scripts you wish to import. If you import multiple scripts, it will create script cues and write the scripts into the cue. If you import a single script and currently have a script cue selected, it will write the script into that cue.

## Tags

- `@description` Name of the script
- `@author` Most recent author of the script
- `@link` Link to the author's website
- `@source` Where scripts are taken from another source, or adapted from one, that author is listed here
- `@version` Version of the script
- `@about` A description of the script
- `@changelog` Changes for this version of the script

## Credits
The general idea for the structure of QLab scripts and how to deal with them is adopted of Ben Smiths [QLab Scripts](https://github.com/bsmith96/Qlab-Scripts).

In all scripts that are adapted from publicly available versions, the original author is credited in the `@source` tag, in the header of the file.
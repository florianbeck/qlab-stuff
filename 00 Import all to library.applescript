-- @description Import all script to user library
-- @author Florian Beck
-- @link florianbeck.de
-- @source Ben Smith (adapted)
-- @version 1.0
-- @testedmacos 11.7.3
-- @testedqlab 4.7
-- @about Run this script in MacOS's "Script Editor" to import all scripts in a folder (including within subfolders) to the user's "Library/Script Libraries"
-- @separateprocess TRUE

-- @changelog
-- v1.0 + initial version adapted of Ben Smiths script


-- USER DEFINED VARIABLES -----------------

set gitVersionToGet to "latest" -- latest, or a git version tag. If using an old file, set this to the version previously installed.


---------- END OF USER DEFINED VARIABLES --


-- RUN SCRIPT -----------------------------

set theMethod to button returned of (display dialog "Would you like to install from github, or from a local folder?" with title "Install from github?" buttons {"Github", "Local", "Cancel"} default button "Github")

global scriptFiles
set scriptFiles to {}

-- Git clone the current master branch
if theMethod is "Github" then
	tell application "Finder"
		set homeLocation to path to home folder
		
		if gitVersionToGet is "latest" then
			set gitClone to "cd " & (POSIX path of homeLocation) & "&& git clone https://github.com/florianbeck/qlab-stuff.git qlab-scripts-temp"
		else
			set gitClone to "cd " & (POSIX path of homeLocation) & "&& git clone https://github.com/florianbeck/qlab-stuff qlab-scripts-temp -b " & gitVersionToGet & " --single-branch"
		end if
		
		do shell script gitClone
		
		set scriptFolder to (POSIX path of homeLocation) & "qlab-scripts-temp"
		set scriptFolder to (POSIX file scriptFolder) as alias
		
		-- Get version number for notes
		set getGitVersion to "cd " & (POSIX path of scriptFolder) & "&& git describe --tags"
		
		set gitVersion to do shell script getGitVersion
		
	end tell
end if

-- Get user input: folder to import
if theMethod is "Local" then
	tell application "Finder"
		set currentPath to container of (path to me) as alias
	end tell
	
	set scriptFolder to choose folder with prompt "Please select the folder containing scripts to import" default location currentPath
end if
findAllScripts(scriptFolder)

tell application "Finder"
	
	repeat with eachScript in scriptFiles
		set fileName to name of (info for (eachScript as alias) without size)
		if fileName ends with ".applescript" then
			set fileName to (characters 1 thru -(12 + 1) of fileName as string)
		end if
		
		set rootPath to POSIX path of (scriptFolder as alias)
		set originalPath to POSIX path of (eachScript as alias)
		set pathInRoot to my trimLine(originalPath, rootPath, 0)
		set pathInLibrary to my trimLine(pathInRoot, ".applescript", 1)
		
		try
			set newRoot to (POSIX path of (path to library folder from user domain) & "Script Libraries/")
			set testRoot to (POSIX file newRoot as alias)
		on error
			-- if folder doesn't exist
			set rootFolderName to "Script Libraries"
			set rootFolderPath to (POSIX path of (path to library folder from user domain))
			set newRootFolder to make new folder at (POSIX file rootFolderPath as alias)
			set name of newRootFolder to rootFolderName
			set newRoot to (POSIX path of (path to library folder from user domain) & rootFolderName & "/")
		end try
		set newPath to newRoot & pathInRoot
		set newPath to my trimLine(newPath, ".applescript", 1) & ".scpt"
		
		-- compile script
		
		set newFolder to my trimLine(newPath, fileName & ".scpt", 1)
		log newFolder
		try
			set testFolder to (POSIX file newFolder as alias)
		on error
			-- if folder doesn't exist
			set theFolderName to my trimLine(newFolder, newRoot, 0)
			set theFolderPath to my splitString(theFolderName, "/")
			repeat with eachFolder from 1 to ((count of theFolderPath) - 1)
				try
					set theFolder to make new folder at (POSIX file newRoot as alias)
					set name of theFolder to (item eachFolder of theFolderPath) as string
				on error
					try
						delete theFolder
					end try
				end try
				set newRoot to newRoot & (item eachFolder of theFolderPath) & "/"
			end repeat
		end try
		
		set osaCommand to "osacompile -o \"" & newPath & "\" \"" & originalPath & "\""
		log osaCommand
		log pathInLibrary
		
		try
			do shell script osaCommand
		end try
	end repeat
	
end tell


if theMethod is "Github" then
	tell application "Finder"
		delete folder scriptFolder
	end tell
	
	try
		tell application id "com.figure53.Qlab.4" to tell front workspace
			-- set q number of (last item of (selected as list)) to gitVersion
			set installerCue to last item of (selected as list)
			if q type of installerCue is "Script" then
				set installerName to q display name of installerCue
				set originalInstallerName to last item of my splitString(installerName, " | ")
				set q name of installerCue to gitVersion & " installed | " & originalInstallerName
			end if
		end tell
	end try
end if

display notification "Installation complete - all scripts have been compiled into the \"Script Libraries\" folder"


-- FUNCTIONS ------------------------------

on findAllScripts(theFolder)
	tell application "Finder"
		set allItems to every item of theFolder
		
		repeat with eachItem in allItems
			if ((class of eachItem) as string) contains "fol" then
				my findAllScripts(eachItem)
			else
				if name extension of (info for (eachItem as alias) without size) is "applescript" then
					if (name of (info for (eachItem as alias) without size) starts with "00") is false then
						set end of scriptFiles to eachItem
					end if
				end if
			end if
			
		end repeat
		
	end tell
end findAllScripts

on trimLine(theText, trimChars, trimIndicator)
	-- trimIndicator options:
	-- 0 = beginning
	-- 1 = end
	-- 2 = both
	
	set x to the length of the trimChars
	
	
	---- Trim beginning
	
	if the trimIndicator is in {0, 2} then
		repeat while theText begins with the trimChars
			try
				set theText to characters (x + 1) thru -1 of theText as string
			on error
				-- if the text contains nothing but the trim characters
				return ""
			end try
		end repeat
	end if
	
	
	---- Trim ending
	
	if the trimIndicator is in {1, 2} then
		repeat while theText ends with the trimChars
			try
				set theText to characters 1 thru -(x + 1) of theText as string
			on error
				-- if the text contains nothing but the trim characters
				return ""
			end try
		end repeat
	end if
	
	return theText
end trimLine

on splitString(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the array
	return theArray
end splitString
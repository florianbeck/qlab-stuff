-- @description Import scripts to cues
-- @author Florian Beck
-- @link www.florianbeck.de
-- @source Ben Smith
-- @version 2.0
-- @about Run this script in MacOS's "Script Editor" to quickly create script cues using the scripts in this repository. 

-- @changelog
--   v2.0 + upgraded for qlab5, do without version testing and importing the whole sctipt including comments

-- RUN SCRIPT -----------------------------

-- Get user input: scripts to generate cues for

set scriptFiles to choose file with prompt "Please select the scripts to import" of type {"public.text"} with multiple selections allowed

-- Repeat with each selected script

repeat with eachScript in scriptFiles
	
	-- Create a list of each line of the script
	
	set eachScriptContents to paragraphs of (read eachScript)
	
	set scriptContents to ""
	
	log "-----------"
	
	repeat with eachLine in eachScriptContents
		
		-- Get tags
		
		if eachLine contains "@description" then
			set eachScriptDescription to trimLine(eachLine, "-- @description ", 0)
			log "Description: " & eachScriptDescription
		else if eachLine contains "@author" then
			set eachScriptAuthor to trimLine(eachLine, "-- @author ", 0)
			log "Author: " & eachScriptAuthor
		else if eachLine contains "@source" then
			set eachScriptSource to trimLine(eachLine, "-- @source ", 0)
			log "Source: " & eachScriptSource
		else if eachLine contains "@about" then
			set eachScriptAbout to trimLine(eachLine, "-- @about ", 0)
			log "About: " & eachScriptAbout
		end if
		
		-- Get script source
		
		--if eachLine does not contain "-- @" and eachLine does not contain "--   " then
		set scriptContents to scriptContents & "
" & eachLine
		--end if
		
		set scriptContents to my trimLine(scriptContents, "
", 0)
		
	end repeat
	
	tell application id "com.figure53.Qlab.5" to tell front workspace
		
		-- Get cue to write, or create cue
		
		set selectedCues to (selected as list)
		
		if (length of scriptFiles is 1) and (length of selectedCues is 1) and (q type of item 1 of selectedCues is "Script") then
			set scriptCue to last item of (selected as list)
		else
			make type "Script"
			set scriptCue to last item of (selected as list)
		end if
		
		-- Set cue name
		
		try
			set q name of scriptCue to eachScriptDescription
		on error
			tell application "System Events"
				set cueName to name of eachScript
				set cueName to my trimLine(cueName, ".applescript", 1)
			end tell
			set q name of scriptCue to cueName
		end try
		
		-- Set cue note
		
		try
			set cueNote to eachScriptAbout
			try
				set cueNote to cueNote & " (" & eachScriptAuthor
				try
					set cueNote to cueNote & " // " & eachScriptSource & ")"
				on error
					set cueNote to cueNote & ")"
				end try
			end try
			set notes of scriptCue to cueNote
		end try
		
		-- Set script source
		
		try
			set script source of scriptCue to scriptContents
		end try
		
	end tell
	
end repeat


-- FUNCTIONS ------------------------------

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
-- @description Timecode for Audiocue
-- @author Florian Beck
-- @link www.florianbeck.de
-- @version 1.1
-- @about Adds a corresponding timecode cue to an audio cue and puts everything in a group to fire simultanious. Timecode settings should be set in the cue template before. If the group is selected, everything is undone.

-- @changelog
--   v1.0 + initial version
-- v1.1 + Added warning dialogs if the audio cue or timecode group is non-standard.

---- VARIABLES ------------------------

set groupNameAppend to " + TC" -- set text to be appended to the group cue. Leave blank so no text is appended.

---- RUN SCRIPT ---------------------------

tell application id "com.figure53.Qlab.5" to tell front workspace
	set eachCues to (selected as list)
	repeat with eachCue in eachCues
		set eachCueType to q type of eachCue
		if eachCueType is in "Audio" then
			if q type of second item of cues of parent of eachCue is "Timecode" then
				display dialog "WARNING: It seems that the audio cue you've selected is already in a Timecode group." & return & return & "PROCEED?"
			end if
			set eachCueNumber to q number of eachCue
			set q number of eachCue to ""
			make type "Timecode"
			set timecodeCue to last item of (selected as list)
			set duration of timecodeCue to (get duration of eachCue)
			set q number of timecodeCue to ""
			set cuesToGroup to {eachCue, timecodeCue}
			make type "Group"
			set groupCue to last item of (selected as list)
			move cue id (uniqueID of groupCue) of parent of groupCue to after cue id (uniqueID of eachCue) of parent of eachCue
			set q number of groupCue to eachCueNumber
			set q name of groupCue to (q list name of eachCue) & (groupNameAppend as string)
			repeat with eachCue in cuesToGroup
				move cue id (uniqueID of eachCue) of parent of eachCue to end of groupCue
			end repeat
			collapse groupCue
		else if eachCueType is in "Group" then
			try
				set secondChildType to q type of second item of cues of eachCue
			on error
				set secondChildType to false
			end try
			if secondChildType is not "Timecode" then
				display dialog "WARNING: It seems that the group cue you've selected is not a Timecode group." & return & return & "PROCEED?"
			end if
			set theGroupNumber to q number of eachCue
			set q number of eachCue to ""
			set audioCue to first item of cues of eachCue
			set q number of audioCue to theGroupNumber
			move cue id (uniqueID of audioCue) of eachCue to after cue id (uniqueID of eachCue) of parent of eachCue
			delete cue id (uniqueID of eachCue) of parent of eachCue
		end if
	end repeat
end tell
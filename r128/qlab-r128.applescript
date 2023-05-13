-- @description Loudness Normalization of Audiocues
-- @author Florian Beck
-- @link florianbeck.de
-- @source Mic Pool (adapted)
-- @version 2.0
-- @testedmacos 11.7.3
-- @testedqlab 4.7
-- @about Loudness Normalization of Audiocues in Accordance with EBU R 128 adjusting the Master Volume.
-- @separateprocess TRUE

-- @changelog
--   v2.0  + initial version adopted of micpools level-playing-field script

-- USER DEFINED VARIABLES -----------------

try -- if global variables are given when this script is called by another, use those variables
	theReferenceLevel
on error
	set theReferenceLevel to -23 -- set desired LUFS level
end try
try
	thefaderLevel
on error
	set thefaderLevel to 0 -- set the master fader level to your preferred output level for cues with an LUFS at the reference level
end try
try
	cliPath
on error
	set cliPath to "/usr/local/bin" -- set the path to r128x-cli (no trailing slash)
end try

---------- END OF USER DEFINED VARIABLES --

---- RUN SCRIPT ---------------------------

tell application id "com.figure53.QLab.4" to tell front workspace
	display dialog "WARNING: This will change the master levels of all selected cues" & return & return & "A dialog will signal when the level setting is complete." & return & return & "PROCEED?"
	try
		set theselected to the selected as list
		
		if (count of items of theselected) > 0 then
			repeat with eachcue in theselected
				
				if q type of eachcue is "audio" then
					
					set currentFileTarget to quoted form of POSIX path of (file target of eachcue as alias)
					set theLUFS to (do shell script "echo $( " & (cliPath as string) & "/r128x-cli " & (currentFileTarget as string) & " | tail -n1 | awk '{print $(NF-2)}' | sed 's/\\./" & character 2 of ((1 / 2) as text) & "/g' )") as real
					set theadjustment to (theReferenceLevel - theLUFS) + thefaderLevel
					-- set the notes of eachcue to "LUFS: " & theLUFS & ", Adjustment: " & theadjustment
					eachcue setLevel row 0 column 0 db theadjustment
					
				end if
			end repeat
			display dialog "Level Setting Complete." buttons "OK" default button "OK"
		end if
	end try
end tell

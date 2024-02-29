-- @description Loudness Normalization
-- @author Florian Beck
-- @link www.florianbeck.de
-- @source Mic Pool
-- @version 2.1
-- @about Loudness Normalization of Audiocues in accordance with EBU R 128 adjusting the cues master volume. Requirements: External CLI tool r128x by Audionuma (please note @readme in the script source).

-- @readme The Loudness Normalization script requires a external CLI tool for the loundess measurement. The tool is called r128x by Audionuma. You can download a compiled version of r128x-cli from the [Github Repository](https://github.com/audionuma/r128x/releases/latest). To use it, you install the file called `r128x-cli` into the folder `/usr/local/bin`. Once youÕve installed r128x-cli into the /bin folder, right-click (or two-finger-click, or control-click) on it, mouse over to the Open withÉ submenu, and choose Terminal. YouÕll be presented with a warning; do you really want to do this? Answer yes, you do. It will open a window in Terminal.app and run itself. Once thatÕs done, which will be more or less immediate, simply quit Terminal. After you do this once, your Mac will regard this file as safe to run.

-- @changelog
--   v2.1 + change to global variables
--   v2.0 + initial version adapted of micpools level-playing-field script

---- VARIABLES ------------------------

set referenceLevel to -23 -- set desired LUFS level
set faderLevel to 0 -- set the master fader level to your preferred output level for cues with an LUFS at the reference level
set cliPath to "/usr/local/bin" -- set the path to r128x-cli (no trailing slash)

---- RUN SCRIPT ---------------------------

tell application id "com.figure53.QLab.5" to tell front workspace
	display dialog "WARNING: This will change the master levels of all selected cues" & return & return & "A dialog will signal when the level setting is complete." & return & return & "PROCEED?"
	try
		set theselected to the selected as list
		
		if (count of items of theselected) > 0 then
			repeat with eachcue in theselected
				
				if q type of eachcue is "audio" then
					
					set currentFileTarget to quoted form of POSIX path of (file target of eachcue as alias)
					set theLUFS to (do shell script "echo $( " & (cliPath as string) & "/r128x-cli " & (currentFileTarget as string) & " | tail -n1 | awk '{print $(NF-2)}' | sed 's/\\./" & character 2 of ((1 / 2) as text) & "/g' )") as real
					set theAdjustment to (referenceLevel - theLUFS) + faderLevel
					set the notes of eachcue to "LUFS: " & theLUFS & ", Adjustment: " & theAdjustment
					eachcue setLevel row 0 column 0 db theAdjustment
					
				end if
			end repeat
			display dialog "Level Setting Complete." buttons "OK" default button "OK"
		end if
	end try
end tell

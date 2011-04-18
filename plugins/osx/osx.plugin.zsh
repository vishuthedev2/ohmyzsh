function savepath() {
  pwd > ~/.current_path~
}

function tab() {
savepath
osascript >/dev/null <<EOF
    tell application "System Events"
      tell process "Terminal" to keystroke "t" using command down
    end
    tell application "Terminal"
      activate
      do script with command "cd \"$PWD\"; $*" in window 1
    end tell

EOF
}



function ntab() {
if [[ $# == 0 ]]; then
      ThisDirectory=$PWD
elif [[ $# == 1 && -d "$1" ]]; then
      ThisDirectory="$@"
else
      print "usage: ntab [directory]"
      return 1
fi

osascript <<-eof
 tell app "Finder"
 activate
tell application "iTerm"
	-- make new terminal
	tell the front terminal 
		activate current session
		launch session "Default Session"
		tell the current session
			write text "cd \"$ThisDirectory\""
		end tell
	end tell
end tell
tell application "Finder"
	activate
end tell
tell application "iTerm"
	activate
end tell
 end tell
eof
}
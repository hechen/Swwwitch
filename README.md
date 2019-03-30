# Swwwitch


Just a tutorial for practise.


![Interface](.assets/main.png)



## Logic Under the hood

1. Switch your system theme using AppleScript
2. Hide / Show your desktop icons using NSTask(aka Process)
3. MenuBar only when your Cocoa Application is agent.


### System Appearance Switch

``` AppleScript
tell application "System Events"
	tell appearance preferences
		set dark mode to not dark mode
	end tell
end tell
```

You can just using ScriptEditor to run this AppleScript to switch the dark theme and light one.


### Hide / Show Desktop Icons

```Shell
defaults write com.apple.finder CreateDesktop false
killall Finder
```

Input the two lines in your terminal, icons just hidden.

If you want recover your icons, just change false to true.
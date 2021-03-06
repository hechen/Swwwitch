# Swwwitch

![Build Status](https://travis-ci.com/hechen/Swwwitch.svg?branch=master)   ![Swift Version](https://img.shields.io/badge/Swift-4.2-F16D39.svg?style=flat)

Just a switch tutorial.


![Interface-c300](.assets/main.png)


That switch your system theme needs your authorization. Just click OK.

![System Event-c300](.assets/systemEvent.png)


## Under the hood

1. Switch your system theme using AppleScript
2. Hide / Show your desktop icons using NSTask(aka Process)
3. MenuBar only when your Cocoa Application is agent.
4. Start at login using serviceManagement (embed a helper login app to wake main application up.)


### System Appearance Switch

``` AppleScript
tell application "System Events"
	tell appearance preferences
		set dark mode to not dark mode
	end tell
end tell
```

You can just using ScriptEditor to run this AppleScript to switch the dark theme and light one.

``` AppleScript to Run
applescript://com.apple.scripteditor?action=new&name=Change%20Theme&script=tell%20application%20%22System%20Events%22%0D%09tell%20appearance%20preferences%0D%09%09set%20dark%20mode%20to%20not%20dark%20mode%0D%09end%20tell%0Dend%20tell
```


### Hide / Show Desktop Icons

```Shell
defaults write com.apple.finder CreateDesktop false
killall Finder
```

Input the two lines in your terminal, icons just hidden.

If you want recover your icons, just change `false` to `true`.


<a href="applescript://com.apple.scripteditor?action=new&name=Hide%20Desktop%20Icons&script=tell%20application%20%22Terminal%22%0D%20%20%20%20do%20script%20%22defaults%20write%20com.apple.finder%20CreateDesktop%20false%3b%20killall%20Finder%22%0Dend%20tell">hide Desktop Icons</a>

<a href="applescript://com.apple.scripteditor?action=new&name=Hide%20Desktop%20Icons&script=tell%20application%20%22Terminal%22%0D%20%20%20%20do%20script%20%22defaults%20write%20com.apple.finder%20CreateDesktop%20true%3b%20killall%20Finder%22%0Dend%20tell">show Desktop Icons</a>


### Caffeinate

``` Shell
# enable caffeinate forever.
# never return.
caffeinate

# disable caffeinate
killall caffeinate 
```



## Links
[Checkout all command lines macOS Support](https://ss64.com/osx/)

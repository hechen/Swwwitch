//
//  Appearance.swift
//  Swwwitch
//
//  Created by chen he on 2019/3/30.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa


class Appearance {
    class var isDarkTheme: Bool {
        return NSAppearance.current.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
    }
    
    @discardableResult
    class func switchTheme(dark: Bool) -> Bool {
        let myAppleScript = """
            tell application "System Events"
                tell appearance preferences
                    set dark mode to \(dark ? "true" : "false")
                end tell
            end tell
            """        
        var error: NSDictionary?
        guard let scriptObject = NSAppleScript(source: myAppleScript) else { return false }
        scriptObject.executeAndReturnError(&error)
        return error == nil
    }
}

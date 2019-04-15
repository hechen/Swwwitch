//
//  IconHider.swift
//  Swwwitch
//
//  Created by chen he on 2019/3/30.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation

class IconHider {
    class func hidden() -> Bool {
        let result = ReadDesktopIconHiddenTask().executeSync()
        if !result.success {
            return false
        }
        
        // result.output
        if let output = result.output {
            return output.contains("false")
        }
        return false
    }
    
    @discardableResult
    class func switchHidden(_ hide: Bool = true) -> Bool {
        if hidden() == hide { return true }
        return SwitchDesktopIconTask(hide: hide).executeSync().success
    }
}




/*
 defaults write com.apple.finder CreateDesktop true
 killall Finder
 */
class SwitchDesktopIconTask: Task {
    lazy var arguments: [String] = {
        var argvs = ["-c"]
        if self.hide {
            argvs.append("defaults write com.apple.finder CreateDesktop false; killall Finder")
        } else {
            argvs.append("defaults write com.apple.finder CreateDesktop true; killall Finder")
        }
        return argvs
    }()
    
    let hide: Bool
    init(hide: Bool = true) {
        self.hide = hide
    }
}

class ReadDesktopIconHiddenTask: Task {
    var arguments: [String] {
        return [
            "-c",
            "defaults read com.apple.finder CreateDesktop"
        ]
    }
}


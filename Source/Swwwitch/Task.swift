//
//  Task.swift
//  Swwwitch
//
//  Created by chen he on 2019/3/30.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation

/*
 U can find all avaliable bash commands here.
 https://gist.github.com/demoive/1fb18a74defe724a47aa
 */

protocol Task {
    var arguments: [String] { get }
    var launchPath: String { get }
    func execute() -> Bool
}

extension Task {
    var launchPath: String {
        return "/bin/bash"
    }
}

extension Task {
    func execute() -> Bool {
        let process = Process()
        process.launchPath = launchPath
        process.arguments = arguments
        
        process.launch()
        process.waitUntilExit()
        return process.terminationStatus == 0
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

class ThemeTask {
    
}

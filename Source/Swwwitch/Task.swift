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
typealias ProcessStatus = Bool
typealias ProcessResult = String

typealias ProcessTerminateResult = (success: ProcessStatus, output: ProcessResult?)

protocol Task {
    var arguments: [String] { get }
    var launchPath: String { get }
    func executeSync() -> ProcessTerminateResult
}

extension Task {
    var launchPath: String {
        return "/bin/bash"
    }
    
    func executeSync() -> ProcessTerminateResult {
        let process = Process()
        process.launchPath = launchPath
        process.arguments = arguments
        
        let output = Pipe()
        process.standardOutput = output
        
        process.launch()
        process.waitUntilExit()
        
        let data = output.fileHandleForReading.readDataToEndOfFile()
        if let result = String(data: data, encoding: .utf8) {
            return (process.terminationStatus == 0, result)
        }
        return (process.terminationStatus == 0, nil)
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

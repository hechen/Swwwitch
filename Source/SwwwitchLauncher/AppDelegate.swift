//
//  AppDelegate.swift
//  SwwwitchLauncher
//
//  Created by chen he on 2019/3/31.
//  Copyright © 2019 chen he. All rights reserved.
//


import Cocoa

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject {
    
    @objc func terminate() {
        NSApp.terminate(nil)
    }
}

extension AppDelegate: NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let mainAppIdentifier = "app.chen.osx.Swwwitch"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty
        
        if !isRunning {
            DistributedNotificationCenter.default().addObserver(self,
                                                                selector: #selector(self.terminate),
                                                                name: .killLauncher,
                                                                object: mainAppIdentifier)
            
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("Swwwitch") //main app name
            
            let newPath = NSString.path(withComponents: components)
            
            NSWorkspace.shared.launchApplication(newPath)
        }
        else {
            self.terminate()
        }
    }
}

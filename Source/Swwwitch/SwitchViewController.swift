//
//  SwitchViewController.swift
//  Swwwitch
//
//  Created by chen he on 2019/3/30.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

class SwitchViewController: NSViewController {
    
    
    @IBOutlet weak var themeContainerView: NSView!
    
    @IBOutlet weak var hideDesktopContainerView: NSView!
    
    
    @IBOutlet weak var themeSwitch: NSSwitch!
    @IBOutlet weak var hideIconsSwitch: NSSwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        themeContainerView.backgroundColor = .clear
        hideDesktopContainerView.backgroundColor = .clear
        
        hideIconsSwitch.delegate = self
        hideIconsSwitch.setOn(on: AppDefaults.shared.desktopIconsHidden, animated: false)
        
        themeSwitch.delegate = self
        themeSwitch.setOn(on: Appearance.isDarkTheme, animated: false)
    }
    
    @IBAction func quitAction(_ sender: Any) {
        NSApp.terminate(sender)
    }
}

extension SwitchViewController : NSSwitchDelegate {
    func switchChanged(switch switcher: NSSwitch) {
        switch switcher {
        case hideIconsSwitch:
            if AppDefaults.shared.desktopIconsHidden == switcher.on { return }
            let task: Task = SwitchDesktopIconTask(hide: switcher.on)
            if task.execute() {
                AppDefaults.shared.desktopIconsHidden = !AppDefaults.shared.desktopIconsHidden
            }
        case themeSwitch:
            if Appearance.isDarkTheme == switcher.on { return }
            _ = Appearance.switchTheme()
            
        default: break
            
        }
    }
}


extension SwitchViewController {
    static func instantiateController() -> SwitchViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("SwitchViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? SwitchViewController else {
            fatalError("cannot find SwitchViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

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
        hideIconsSwitch.setOn(on: DesktopIconHelper.hidden(), animated: true)
        
        themeSwitch.delegate = self
        themeSwitch.setOn(on: Appearance.isDarkTheme, animated: true)
    }
    
    @IBAction func quitAction(_ sender: Any) {
        NSApp.terminate(sender)
    }
}

extension SwitchViewController : NSSwitchDelegate {
    func switchChanged(switch switcher: NSSwitch) {
        switch switcher {
        case hideIconsSwitch:
            if !DesktopIconHelper.switchHidden(switcher.on) {
                print("Switch Hidden Failed!")
            }
        case themeSwitch:
            if !Appearance.switchTheme(dark: switcher.on) {
                print("Switch Theme Failed!")
            }
            
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

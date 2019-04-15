//
//  SwitchViewController.swift
//  Swwwitch
//
//  Created by chen he on 2019/3/30.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa
import ServiceManagement

class SwitchViewController: NSViewController {
    @IBOutlet weak var themeContainerView: NSView!
    
    @IBOutlet weak var hideDesktopContainerView: NSView!
    @IBOutlet weak var startAtLoginButton: NSButton!
    
    
    @IBOutlet weak var themeSwitch: NSSwitch!
    @IBOutlet weak var hideIconsSwitch: NSSwitch!
    @IBOutlet weak var caffeinateSwitch: NSSwitch!
    
    lazy var launchHelperIdentifier: String = {
        return "app.chen.osx.SwwwitchLauncher"
    }()
    
    var launchAtStartup: Bool {
        get {
            let jobs = SMCopyAllJobDictionaries(kSMDomainUserLaunchd).takeRetainedValue() as? [[String: AnyObject]]
            return jobs?.contains(where: { $0["Label"] as! String == launchHelperIdentifier }) ?? false
        }
        set {
            SMLoginItemSetEnabled(launchHelperIdentifier as CFString, newValue)
        }
    }
    
    let queue = DispatchQueue(label: "app.chen.osx.swwwitch.hidden", attributes: [.concurrent])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        themeContainerView.backgroundColor = .clear
        hideDesktopContainerView.backgroundColor = .clear
        
        hideIconsSwitch.delegate = self
        themeSwitch.delegate = self
        caffeinateSwitch.delegate = self
    }
    
    override func viewWillAppear() {
        queue.async {
            let hidden = IconHider.hidden()
            DispatchQueue.main.async {  [weak self] in
                self?.hideIconsSwitch.setOn(on: hidden, animated: true)
            }
        }
        startAtLoginButton.isOn = launchAtStartup
        themeSwitch.setOn(on: Appearance.isDarkTheme, animated: true)
        queue.async {
            let active = Caffeinate.isActive
            DispatchQueue.main.async { [weak self] in
                self?.caffeinateSwitch.setOn(on: active, animated: true)
            }
        }
    }
    
    @IBAction func quitAction(_ sender: Any) {
        NSApp.terminate(sender)
    }
    
    @IBAction func startAtLoginChecked(_ sender: Any) {
        // change the launcher helper's login status
        // for get return value. Use the method separately.
        if !SMLoginItemSetEnabled(launchHelperIdentifier as CFString, startAtLoginButton.isOn) {
            // revert
            startAtLoginButton.isOn = !startAtLoginButton.isOn
            
            let alert = NSAlert()
            alert.messageText = "An error ocurred."
            alert.addButton(withTitle: "OK")
            alert.informativeText = "Couldn't add Helper App to launch at login item list."
            alert.runModal()
        }
    }
}

extension SwitchViewController : NSSwitchDelegate {
    func switchChanged(switch switcher: NSSwitch) {
        switch switcher {
        case hideIconsSwitch:
            queue.async {
                IconHider.switchHidden(switcher.on)
            }
        case themeSwitch:
            queue.async {
                Appearance.switchTheme(dark: switcher.on)
            }
        case caffeinateSwitch:
            queue.async {
                Caffeinate.switchCaffeinate(enable: switcher.on)
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

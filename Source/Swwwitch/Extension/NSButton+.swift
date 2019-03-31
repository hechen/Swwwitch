//
//  NSButton+.swift
//  Swwwitch
//
//  Created by chen he on 2019/3/30.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

extension NSButton {
    
    var isOn: Bool {
        
        get {
            return state == .on
        }
        
        set {
            state = newValue ? .on : .off
        }
        
    }
    
}

//
//  DesktopIconHelper.swift
//  Swwwitch
//
//  Created by chen he on 2019/3/30.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation

class DesktopIconHelper {
    
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
    
    class func switchHidden(_ hide: Bool = true) -> Bool {
        if hidden() == hide { return true }
        return SwitchDesktopIconTask(hide: hide).executeSync().success
    }
}

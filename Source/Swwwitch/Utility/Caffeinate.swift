//
//  Caffeinate.swift
//  Swwwitch
//
//  Created by chen he on 2019/4/15.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation


class Caffeinate {
    class var isActive: Bool {
        let result = CheckCaffeinateTask().executeSync()
        if !result.success {
            return false
        }
        if let output = result.output {
            return output.contains("caffeinate")
        }
        return false
     }
    
    /// need be cautious, caffeinate without time param will not return...
    /// execute kill caffeinate will ternimate the previous enable one, which will return
    class func switchCaffeinate(enable: Bool) {
        _ = CaffeinateTask(enable: enable).executeSync()
    }
}

class CheckCaffeinateTask: Task {
    var arguments: [String] {
        return [
            "-c",
            "ps -eo etime,args|grep caffeinate|grep -v grep|sed -e 's|^[[:space:]]*||'"]
    }
}

class CaffeinateTask: Task {
    var arguments: [String] {
        var argvs = ["-c"]
        if self.enable {
            argvs.append("caffeinate")
        } else {
            argvs.append("killall caffeinate")
        }
        return argvs
    }
    
    let enable: Bool
    init(enable: Bool = true) {
        self.enable = enable
    }
}

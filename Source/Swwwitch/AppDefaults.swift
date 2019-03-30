//
//  AppDefaults.swift
//  Swwwitch
//
//  Created by chen he on 2019/3/30.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation


public protocol KeyValueStoreType: class {
    func bool(for key: String) -> Bool
    func setBool(for key: String, _ flag: Bool)
}

extension KeyValueStoreType {
    public var desktopIconsHidden: Bool {
        get {
            return bool(for: AppKeys.hideDesktopIcons.rawValue)
        }
        set {
            setBool(for: AppKeys.hideDesktopIcons.rawValue, newValue)
        }
    }
}


enum AppKeys: String {
    case hideDesktopIcons
}

public class AppDefaults {
    static var shared = AppDefaults()
    @discardableResult init() {
        let defaults: [String: Any] = [
            AppKeys.hideDesktopIcons.rawValue: false
        ]
        UserDefaults.standard.register(defaults: defaults)
    }
}

extension AppDefaults: KeyValueStoreType {
    public func bool(for key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    public func setBool(for key: String, _ flag: Bool) {
        UserDefaults.standard.set(flag, forKey: key)
    }
}

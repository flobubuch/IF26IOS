//
//  SettingUserDefaults.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 17/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation

class SettingUserDefaults {
    private struct Keys {
        static let userNameConnected = "userNameConnected"
    }
    
    static var userNameConnected : String {
        get{
            return UserDefaults.standard.string(forKey: Keys.userNameConnected)!
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: Keys.userNameConnected)
        }
    }
}

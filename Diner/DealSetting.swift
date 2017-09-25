//
//  DealSetting.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/24/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import Foundation

class Deal: Setting {
    var name: String = ""
    
    var preferences: [Preference] {
        get {
            return [Preference(label: "Offering a Deal", code: "deals")]
        }
    }
}

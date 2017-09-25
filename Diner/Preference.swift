//
//  Preference.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/24/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import Foundation

struct Preference {
    var label: String = ""
    var code: String = ""
    
    init(label: String, code: String) {
        self.code = code
        self.label = label
    }
}

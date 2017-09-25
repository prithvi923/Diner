//
//  DistanceSetting.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/24/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import Foundation

class Distance: Setting {
    var name: String = "Distance"
    
    var preferences: [Preference]
    
    init(_ isSelected: String) {
        self.preferences = [
            Preference(label: "0.3 mile", code: "0.3"),
            Preference(label: "1 mile", code: "1"),
            Preference(label: "5 miles", code: "5"),
            Preference(label: "10 miles", code: "10")
        ]
        
        for index in 0..<preferences.count {
            if preferences[index].code == isSelected {
                preferences[index].isSelected = true
            }
        }
    }
}

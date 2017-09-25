//
//  SortSetting.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/24/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import Foundation

class Sort: Setting {
    var name: String = "Sort By"
    
    var preferences: [Preference]
    
    init(_ isSelected: String) {
        self.preferences = [
            Preference(label: "Distance", code: "distance"),
            Preference(label: "Best Match", code: "best_match"),
            Preference(label: "Review Count", code: "review_count"),
            Preference(label: "Rating", code: "rating")
        ]
        for index in 0..<preferences.count {
            if preferences[index].code == isSelected {
                preferences[index].isSelected = true
            }
        }
    }
}

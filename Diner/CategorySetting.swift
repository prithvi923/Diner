//
//  CategorySetting.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/24/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import Foundation

class Category: Setting {
    var name: String = "Category"
    
    var preferences: [Preference] {
        get {
            return [
                Preference(label: "Afghan", code: "afghani"),
                Preference(label: "Indian", code: "indpak"),
                Preference(label: "Mediterranean", code: "mediterranean")
            ]
        }
    }
}

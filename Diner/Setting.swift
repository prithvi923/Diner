//
//  Setting.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/24/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import Foundation

protocol Setting {
    var name: String { get }
    var preferences: [Preference] { get }
}

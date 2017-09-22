//
//  Business.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/21/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import Foundation

class Business {
    
    let name: String?
    let address: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let stars: NSNumber?
    let reviewCount: NSNumber?
    
    init(from: NSDictionary) {
        name = from["name"] as? String
        
        let imageURLString = from["image_url"] as? String
        if imageURLString != nil {
            imageURL = URL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        let location = from["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let firstPart = location!["display_address"] as! [String]
            address = firstPart[0]
        }
        self.address = address
        
        let categoriesArray = from["categories"] as? [NSDictionary]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category["title"] as! String
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = ""
        }
        
        let distanceMeters = from["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2fmi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        stars = from["rating"] as? NSNumber
        
        reviewCount = from["review_count"] as? NSNumber
        
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(from: dictionary)
            businesses.append(business)
        }
        
        return businesses
    }
    
}

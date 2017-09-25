//
//  YelpClient.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/18/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import Foundation
import AFNetworking
import MapKit

class Yelp: NSObject, CLLocationManagerDelegate {
    
    var authToken: String!
    var currentLat: CLLocationDegrees = 37.7746088
    var currentLong: CLLocationDegrees = -122.3957547
    
    override init() {
        super.init()
        getAuth()
    }
    
    func search(_ query: String, parameters: [String: Any?], completion: @escaping ([Business]?, Error?) -> Void) {
        let searchURL = "https://api.yelp.com/v3/businesses/search"
        var myParameters = parameters
        myParameters["latitude"] = currentLat
        myParameters["longitude"] = currentLong
        
        if query != "" {
            myParameters["term"] = query
        }
        
        var request = AFHTTPRequestSerializer().request(withMethod: "GET", urlString: searchURL, parameters: myParameters, error: nil) as URLRequest
        request.addValue("Bearer \(authToken!)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request, completionHandler: { (maybeData, success, error) in
            let data = try! JSONSerialization.jsonObject(with: maybeData!)
            if let responseData = data as? NSDictionary {
                if let businesses = responseData["businesses"] as? [NSDictionary] {
                    completion(Business.businesses(array: businesses), nil)
                }
            }
        })
        
        task.resume()
    }
    
    func search(completion: @escaping ([Business]?, Error?) -> Void) {
        self.search("", parameters: [:], completion: completion)
    }
    
    func search(_ query: String, completion: @escaping ([Business]?, Error?) -> Void) {
        self.search(query, parameters: [:], completion: completion)
    }
    
    func search(_ query: String, withFilters: Filters, completion: @escaping ([Business]?, Error?) -> Void) {
        var parameters: [String: Any?] = [:]
        
        if (withFilters.distance != "") {
            parameters["distance"] = withFilters.distance
        }
        
        if (withFilters.sorter != "") {
            parameters["sort_by"] = withFilters.sorter.lowercased()
        }
        
        if (withFilters.categories.count > 0) {
            parameters["categories"] = withFilters.categories.joined(separator: ",")
        }
        
        if (withFilters.deal) {
            parameters["attributes"] = "deals"
        }
        
        self.search(query, parameters: parameters, completion: completion)
    
    }
    
    func getAuth() {
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict {
            let clientID = dict["clientID"] as! String
            let secret = dict["clientSecret"] as! String
            if let token = dict["authToken"] as? String {
                self.authToken = token
                return
            }
            
            let authURL = "https://api.yelp.com/oauth2/token"
            let parameters = ["client_id": clientID, "client_secret": secret]
            
            let request = AFHTTPRequestSerializer().request(withMethod: "POST", urlString: authURL, parameters: parameters, error: nil) as URLRequest
            
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
            
            let task = session.dataTask(with: request, completionHandler: { (maybeData, success, error) in
                let data = try! JSONSerialization.jsonObject(with: maybeData!)
                if let responseData = data as? NSDictionary {
                    self.authToken = responseData["access_token"] as! String
                    print(self.authToken)
                }
            })
            
            task.resume()
            
        }
    }
    
}

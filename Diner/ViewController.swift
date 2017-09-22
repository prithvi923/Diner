//
//  ViewController.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/18/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var businesses = [Business]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        let yelp = Yelp()
        yelp.search("Indian", completion: { (businesses: [Business]?, error: Error?) -> Void in
            for business in businesses! {
                print(business.name ?? "None")
            }
            self.businesses = businesses!
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell") as! BusinessCell
        cell.business = self.businesses[indexPath.row]
        return cell
    }
}

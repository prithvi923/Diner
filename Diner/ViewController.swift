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
    var searchController: UISearchController!
    var yelpClient: Yelp!
    
    var filters = Filters()
    var isMoreDataLoading = false
    var offset: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
        
        offset = 20
        
        
        yelpClient = Yelp()
        yelpClient.search(completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses!
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilterViewController {
            vc.filters = filters
        } else if let vc = segue.destination as? MapViewController {
            vc.businesses = self.businesses
        }
    }
    
    @IBAction func unwindToMainVC(segue: UIStoryboardSegue) {
        let filtersVC = segue.source as! FilterViewController
        yelpClient.search(searchController.searchBar.text!, withFilters: filtersVC.newFilters ,completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses!
            self.tableView.reloadData()
            self.filters = filtersVC.newFilters
        })
    }

    func loadMoreData() {
        yelpClient.search(searchController.searchBar.text!, withFilters: self.filters, offset: offset, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses.append(contentsOf: businesses!)
            self.tableView.reloadData()
            self.offset = self.offset + 20
            self.isMoreDataLoading = false
            self.tableView.tableFooterView = nil
        })
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

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        yelpClient.search(searchBar.text!, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses!
            self.tableView.reloadData()
        })
    }
}

extension ViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                let tableFooterView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
                let loadingView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                loadingView.startAnimating()
                loadingView.center = tableFooterView.center
                tableFooterView.addSubview(loadingView)
                self.tableView.tableFooterView = tableFooterView
                loadMoreData()
            }
            
        }
    }
}

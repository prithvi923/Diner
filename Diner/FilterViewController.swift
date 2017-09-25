//
//  FilterViewController.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/21/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var settings: [String: [Preference]] = [
                                    "Distance": [Preference](),
                                    "Sort By": [Preference](),
                                    "Category": [Preference]()]
    
    var filters: Filters!
    var newFilters: Filters!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        settings["Category"]?.append(contentsOf: [
                Preference(label: "Afghan", code: "afghani"),
                Preference(label: "Indian", code: "indpak"),
                Preference(label: "Mediterranean", code: "mediterranean")
            ])
        
        settings["Distance"]?.append(contentsOf: [
                Preference(label: "0.3 mile", code: "0.3"),
                Preference(label: "1 mile", code: "1"),
                Preference(label: "5 miles", code: "5"),
                Preference(label: "10 miles", code: "10")
            ])
        
        settings["Sort By"]?.append(contentsOf: [
            Preference(label: "Distance", code: "distance"),
            Preference(label: "Best Match", code: "best_match"),
            Preference(label: "Review Count", code: "review_count"),
            Preference(label: "Rating", code: "rating")
            ])
        
        newFilters = filters
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func searchPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMainVC", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return settings["Distance"]!.count
        case 1:
            return settings["Sort By"]!.count
        case 2:
            return settings["Category"]!.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
        var pref: Preference!
        
        switch indexPath.section {
        case 0:
            pref = (settings["Distance"]?[indexPath.row])!
        case 1:
            pref = settings["Sort By"]?[indexPath.row]
        case 2:
            pref = settings["Category"]?[indexPath.row]
        default:
            pref = Preference(label: "error", code: "error")
        }
        cell.preference = pref
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Distance"
        case 1:
            return "Sort By"
        case 2:
            return "Category"
        default:
            return ""
        }
    }
    
}

extension FilterViewController: SwitchCellDelegate {
    
    func preferenceDidChange(cell: SwitchCell, newValue: Bool) {
        let pref = cell.preference
        let path = tableView.indexPath(for: cell)
        switch path!.section {
        case 0:
            if (newValue) {
                newFilters.distance = (pref?.code)!
            } else {
                newFilters.distance = ""
            }
            return
        case 1:
            if (newValue) {
                newFilters.sorter = (pref?.code)!
            } else {
                newFilters.sorter = ""
            }
            return
        case 2:
            if (newValue) {
                newFilters.categories.append((pref?.code)!)
            } else {
                newFilters.categories = newFilters.categories.filter{$0 != pref?.code}
            }
            return
        default:
            return
        }
    }
}

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
    
    var settings: Array = [Setting]()
    
    var filters: Filters!
    var newFilters: Filters!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        settings.append(Deal())
        settings.append(Distance())
        settings.append(Sort())
        settings.append(Category())
        
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
        return settings[section].preferences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
        let pref = settings[indexPath.section].preferences[indexPath.row]
        cell.preference = pref
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section].name
    }
    
}

extension FilterViewController: SwitchCellDelegate {
    
    func preferenceDidChange(cell: SwitchCell, newValue: Bool) {
        let pref = cell.preference
        let path = tableView.indexPath(for: cell)
        switch path!.section {
        case 0:
            if (newValue) {
                newFilters.deal = true
            } else {
                newFilters.deal = false
            }
        case 1:
            if (newValue) {
                let value = Float(pref!.code)
                newFilters.distance = Int(value! * 1609.34)
            } else {
                newFilters.distance = nil
            }
            return
        case 2:
            if (newValue) {
                newFilters.sorter = (pref?.code)!
            } else {
                newFilters.sorter = ""
            }
            return
        case 3:
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

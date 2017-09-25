//
//  SwitchCell.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/24/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate: AnyObject {
    func preferenceDidChange(cell: SwitchCell, newValue: Bool)
}

class SwitchCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var paramSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func toggled(_ sender: UISwitch) {
        delegate?.preferenceDidChange(cell: self, newValue: sender.isOn)
    }
}

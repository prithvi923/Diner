//
//  BusinessCell.swift
//  Diner
//
//  Created by Prithvi Prabahar on 9/20/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    
    @IBOutlet weak var businessAvatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var business: Business! {
        didSet {
            updateLabels()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateLabels() {
        businessAvatarImageView.setImageWith(business.imageURL!)
        nameLabel.text = business.name!
        
        reviewsLabel.text = "\(business.reviewCount!) Reviews"
        addressLabel.text = business.address!
        categoriesLabel.text = business.categories!
        distanceLabel.text = "\(business.distance!)mi"
    }

}

//
//  RecordsTableViewCell.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/11/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var symptomsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

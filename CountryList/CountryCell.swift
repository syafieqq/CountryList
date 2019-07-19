//
//  CountryCell.swift
//  CountryList
//
//  Created by Megat Syafiq on 13/07/2019.
//  Copyright © 2019 Megat Syafiq. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet weak var countryCode: UILabel!
    
    @IBOutlet weak var cellFrame: UIView!
    @IBOutlet weak var countryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellFrame.layer.cornerRadius = 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

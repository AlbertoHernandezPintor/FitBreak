//
//  WeatherListTableViewCell.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 24/2/21.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var precipitation: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

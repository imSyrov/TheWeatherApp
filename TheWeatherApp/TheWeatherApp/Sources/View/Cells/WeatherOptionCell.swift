//
//  WeatherOptionCell.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import UIKit

class WeatherOptionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!    
    
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
}

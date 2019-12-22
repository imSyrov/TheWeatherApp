//
//  ForecastWeatherCell.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import UIKit

class ForecastWeatherCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!    
    
    func confugure(data: ForecastDataModel) {
        dateLabel.text = data.date?.toString(with: "dd.MM HH:mm")
        degreesLabel.text = data.main?.temperature.toDegrees()
        windSpeedLabel.text = data.wind?.speed.toSpeed()
        if let name = data.options.first?.icon {
            conditionImageView.load(for: name)
        }
    }
}

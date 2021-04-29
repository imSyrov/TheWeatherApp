//
//  MainWeatherModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class MainWeatherModel: Object, Decodable {
    @objc dynamic var temperature: Double = 0.0
    @objc dynamic var pressure: Double = 0.0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var minTemperature: Double = 0.0
    @objc dynamic var maxTemperature: Double = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure
        case humidity
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
    }
}

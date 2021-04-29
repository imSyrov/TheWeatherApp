//
//  ForecastDataModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class ForecastDataModel: Object, Decodable {    
    @objc dynamic var date: Date? = nil
    @objc dynamic var main: MainWeatherModel?
    var options = List<WeatherOptionModel>()
    @objc dynamic var clouds: CloudModel?
    @objc dynamic var wind: WindModel?
    
    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case options = "weather"
        case clouds
        case wind
    }
}

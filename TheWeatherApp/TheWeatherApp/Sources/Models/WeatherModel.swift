//
//  WeatherModel.swift
//  TheWeatherApp
//
//  Created by ilya on 19/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherModel: Object, Decodable {
    @objc dynamic var city: String = ""
    @objc dynamic var current: CurrentWeatherModel?
    @objc dynamic var forecast: ForecastWeatherModel?
        
    init(current: CurrentWeatherModel?, forecast: ForecastWeatherModel?) {
        self.city = current?.name ?? "Undefined"
        self.current = current
        self.forecast = forecast
    }
    
    required init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "city"
    }
}

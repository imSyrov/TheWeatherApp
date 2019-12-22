//
//  CurrentWeatherModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class CurrentWeatherModel: Object, Decodable {
    @objc dynamic var coordinates: CoordinatesModel?
    var options = List<WeatherOptionModel>()
    @objc dynamic var main: MainWeatherModel?
    @objc dynamic var wind: WindModel?
    @objc dynamic var clouds: CloudModel?
    @objc dynamic var date: Date? = nil
    @objc dynamic var system: SystemInformationCurrentModel?
    @objc dynamic var name: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case options = "weather"
        case main
        case wind
        case clouds
        case date = "dt"
        case system = "sys"
        case name
    }
}

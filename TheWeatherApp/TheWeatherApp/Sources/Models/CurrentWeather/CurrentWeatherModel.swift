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
    
    required init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.coordinates = try container.decode(CoordinatesModel.self, forKey: .coordinates)
        self.options = try container.decode(List<WeatherOptionModel>.self, forKey: .options)
        self.main = try container.decode(MainWeatherModel.self, forKey: .main)
        self.wind = try container.decode(WindModel.self, forKey: .wind)
        self.clouds = try container.decode(CloudModel.self, forKey: .clouds)
        self.date = try container.decode(Date.self, forKey: .date)
        self.system = try container.decode(SystemInformationCurrentModel.self, forKey: .system)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    required init() {
        super.init()
    }
}

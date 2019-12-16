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
    
    required init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.temperature = try container.decode(Double.self, forKey: .temperature)
        self.pressure = try container.decode(Double.self, forKey: .pressure)        
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.minTemperature = try container.decode(Double.self, forKey: .minTemperature)
        self.maxTemperature = try container.decode(Double.self, forKey: .maxTemperature)
    }
    
    required init() {
        super.init()
    }
}

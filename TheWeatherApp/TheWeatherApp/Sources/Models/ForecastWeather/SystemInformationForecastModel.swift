//
//  SystemInformationForecastModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class SystemInformationForecastModel: Object, Decodable {
    @objc dynamic var coordinates: CoordinatesModel?
    @objc dynamic var name: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var sunrise: Date? = nil
    @objc dynamic var sunset: Date? = nil
    
    private enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case name
        case country
        case sunrise
        case sunset
    }
    
    required init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.coordinates = try container.decode(CoordinatesModel.self, forKey: .coordinates)
        self.name = try container.decode(String.self, forKey: .name)
        self.country = try container.decode(String.self, forKey: .country)
        self.sunrise = try container.decode(Date.self, forKey: .sunrise)
        self.sunset = try container.decode(Date.self, forKey: .sunset)
    }
    
    required init() {
        super.init()
    }
}

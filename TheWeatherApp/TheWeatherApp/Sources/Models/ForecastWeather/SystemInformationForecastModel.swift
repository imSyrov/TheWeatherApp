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
}

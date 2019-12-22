//
//  CoordinatesModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class CoordinatesModel: Object, Decodable {
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var latitude: Double = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

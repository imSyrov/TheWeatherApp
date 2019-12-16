//
//  WeatherOptionModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherOptionModel: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var main: String = ""
    @objc dynamic var descriptionOption: String = ""
    @objc dynamic var icon: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case main
        case descriptionOption = "description"
        case icon
    }
    
    required init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.main = try container.decode(String.self, forKey: .main)
        self.descriptionOption = try container.decode(String.self, forKey: .descriptionOption)
        self.icon = try container.decode(String.self, forKey: .icon)
    }
    
    required init() {
        super.init()
    }
}

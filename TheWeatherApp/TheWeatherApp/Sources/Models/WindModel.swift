//
//  WindModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class WindModel: Object, Decodable {
    @objc dynamic var speed: Double = 0.0
    @objc dynamic var degrees: Double = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
    }
    
    required init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.degrees = try container.decode(Double.self, forKey: .degrees)
    }
    
    required init() {
        super.init()
    }
}

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
    
    private enum CodingKeys: String, CodingKey {
        case speed
    }
    
    required init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.speed = try container.decode(Double.self, forKey: .speed)
    }
    
    required init() {
        super.init()
    }
}

//
//  CloudModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class CloudModel: Object, Decodable {
    @objc dynamic var cloudness: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case cloudness = "all"
    }
    
    required init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cloudness = try container.decode(Int.self, forKey: .cloudness)
    }
        
    required init() {
        super.init()
    }
}

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
}

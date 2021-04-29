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
}

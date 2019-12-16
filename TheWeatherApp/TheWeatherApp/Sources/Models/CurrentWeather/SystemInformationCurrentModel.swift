//
//  SystemCurrentWeatherModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class SystemInformationCurrentModel: Object, Decodable {
    @objc dynamic var country: String = ""
    @objc dynamic var sunrise: Date? = nil
    @objc dynamic var sunset: Date? = nil
}

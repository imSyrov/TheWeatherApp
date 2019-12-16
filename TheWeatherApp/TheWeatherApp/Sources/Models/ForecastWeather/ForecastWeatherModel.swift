//
//  ForecastWeatherModel.swift
//  TheWeatherApp
//
//  Created by ilya on 13/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class ForecastWeatherModel: Object, Decodable {
    @objc dynamic var city: SystemInformationForecastModel?
    var data = List<ForecastDataModel>()
    
    private enum CodingKeys: String, CodingKey {
        case city
        case data = "list"
    }
    
    required init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.city = try container.decode(SystemInformationForecastModel.self, forKey: .city)
        self.data = try container.decode(List<ForecastDataModel>.self, forKey: .data)
    }
    
    required init() {
        super.init()
    }
}

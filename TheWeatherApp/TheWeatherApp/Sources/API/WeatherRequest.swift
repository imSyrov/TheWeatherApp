//
//  WeatherRequest.swift
//  TheWeatherApp
//
//  Created by ilya on 22/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import Alamofire

class WeatherRequest {
    let API = APIService()
    var parameters: Parameters = ["units" : "metric"]    
    
    func getCurrentWeather(for city: String, completion: @escaping (Result<CurrentWeatherModel>) -> Void) {
        self.parameters["q"] = city
        API.getObject(for: WeatherType.current.rawValue, parameters: parameters, completion: completion)
    }
    
    func getForecastWeather(for city: String, completion: @escaping (Result<ForecastWeatherModel>) -> Void) {
        self.parameters["q"] = city
        API.getObject(for: WeatherType.forecast.rawValue, parameters: parameters, completion: completion)
    }
}

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
    var parameters: Parameters = [:]
    
    init(for city: String) {
        self.parameters["q"] = city
        self.parameters["units"] = "metric"
    }
    
    func getCurrentWeather(complition: @escaping (Result<CurrentWeatherModel>) -> Void) {
        API.getObject(for: WeatherType.current.rawValue, parameters: parameters, complition: complition)
    }
    
    func getForecastWeather(complition: @escaping (Result<ForecastWeatherModel>) -> Void) {
        API.getObject(for: WeatherType.forecast.rawValue, parameters: parameters, complition: complition)
    }
}

//
//  APIWeather.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherType: String {
    case current = "weather"
    case forecast
}

final class APIWeather: Decodable {
    public static let shared = APIWeather()
    
    func getCurrentWeather(city: String, handler: @escaping (Result<CurrentWeatherModel>) -> Void) {
        APIService.shared.getWeather(city: city, weather: .current, handler: handler)
    }
    
    func getForecastWeather(city: String, handler: @escaping (Result<ForecastWeatherModel>) -> Void) {
        APIService.shared.getWeather(city: city, weather: .forecast, handler: handler)
    }
}

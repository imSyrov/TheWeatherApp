//
//  APIService.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import Alamofire

final class APIService: Decodable {
    public static let shared = APIService()
    private let domain = "http://api.openweathermap.org"
    private let endPoind = "/data/2.5"
    private let apiKey = "67012d457377285f7c56f0008dd25f9e"
    
    func getWeather<T: Decodable> (city: String, weather: WeatherType, handler: @escaping (Result<T>) -> Void) {
        
        let parameters = [
            "q" : city,
            "units" : "metric",
            "appid" : apiKey
        ]
        
        guard let url = URL(string: domain)?.appendingPathComponent(endPoind).appendingPathComponent(weather.rawValue) else { return }
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString).responseJSON { response in
            if let error = response.error {
                handler(.failure(error))
            }
            
            guard let data = response.data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let weatherData = try decoder.decode(T.self, from: data)
                handler(.success(weatherData))
            } catch (let error) {
                handler(.failure(error))
            }
        }
    }
    
}

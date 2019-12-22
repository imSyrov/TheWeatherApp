//
//  APIService.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import Alamofire

class APIService: Decodable {
    private let domain = "http://api.openweathermap.org"
    private let path = "/data/2.5"
    private let apiKey = "67012d457377285f7c56f0008dd25f9e"
    
    func getObject<T: Decodable> (for endPoint: String, parameters: Parameters, completion: @escaping (Result<T>) -> Void) {
        
        var allParameters = parameters        
        allParameters["appid"] = apiKey
        
        guard let url = URL(string: domain)?.appendingPathComponent(self.path).appendingPathComponent(endPoint) else { return }
        
        Alamofire.request(url, method: .get, parameters: allParameters, encoding: URLEncoding.queryString).responseJSON { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            guard let data = response.data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let weatherData = try decoder.decode(T.self, from: data)
                completion(.success(weatherData))
            } catch (let error) {
                completion(.failure(error))
            }
        }
    }
    
}

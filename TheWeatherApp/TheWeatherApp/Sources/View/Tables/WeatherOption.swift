//
//  WeatherOption.swift
//  TheWeatherApp
//
//  Created by ilya on 23/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation

enum WeatherOption {
    case temperature(Double)
    case weather(String)
    case humidity(Int)
    case pressure(Double)
    case wind(Double)
    case clodness(Int)
    case minTemperature(Double)
    case maxTemperature(Double)
    case sunrise(Date)
    case sunset(Date)
    case coordinates(CoordinatesModel)
    
    var title: String {
        switch self {
        case .temperature(_):
            return "Temperature"
        case .weather(_):
            return "Weather"
        case .humidity(_):
            return "Humidity"
        case .pressure(_):
            return "Pressure"
        case .wind(_):
            return "Wind"
        case .clodness(_):
            return "Cloudness"
        case .minTemperature(_):
            return "Min Temperature"
        case .maxTemperature(_):
            return "Max Temperature"
        case .sunrise(_):
            return "Sunrise"
        case .sunset(_):
            return "Sunset"
        case .coordinates(_):
            return "Coordinates"
        }
    }
    
    var value: String {
        switch self {
        case let .temperature(value):
            return value.toDegrees()
        case let .weather(value):
            return value
        case let .humidity(value):
            return value.toPercent()
        case let .pressure(value):
            return value.toMmHg()
        case let .wind(value):
            return value.toSpeed()
        case let .clodness(value):
            return value.toPercent()
        case let .minTemperature(value):
            return value.toDegrees()
        case let .maxTemperature(value):
            return value.toDegrees()
        case let .sunrise(value):
            return value.toString(with: "HH.mm.ss")
        case let .sunset(value):
            return value.toString(with: "HH.mm.ss")
        case let .coordinates(value):
            return "(\(value.longitude)',\(value.latitude)')"
        }
    }
}

//
//  Double.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation

extension Double {
    func toDegrees() -> String {
        return (self > 0 ? "+" : "") + "\(Int(self))\u{B0}C"
    }
    func toSpeed() -> String {
        return "\(Int(self)) m/s"
    }
    
    func toPascal() -> String {
        return "\(Int(self * 0.75)) mmHg"
    }
    
    func toCoordinate() -> String {
        return "\(self)'"
    }
}

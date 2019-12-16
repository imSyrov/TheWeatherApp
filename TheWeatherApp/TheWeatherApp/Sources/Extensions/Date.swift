//
//  Date.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation

extension Date {
    func toString(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}

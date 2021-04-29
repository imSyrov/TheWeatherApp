//
//  InternetConnection.swift
//  TheWeatherApp
//
//  Created by ilya on 19/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import SystemConfiguration

class InternetConnection {
    
    func checkConnection() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zaroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zaroSockAddress)
            }
        }
        
        var flag: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        guard let routeReachability = defaultRouteReachability else { return false }
        
        if SCNetworkReachabilityGetFlags(routeReachability, &flag) == false {
            return false
        }
        
        let isReachable = (flag.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needConnection = (flag.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        let connection = (isReachable && !needConnection)
        
        return connection
    }
}

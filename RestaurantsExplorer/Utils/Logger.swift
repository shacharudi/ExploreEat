//
//  Logger.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation

class Logger {
    static public func log(message: Any) {
        print("Log: ", message)
    }
    
    static public func warning(message: Any) {
        print("Warning: ", message)
    }
    
    static public func error(message: Any) {
        print("Error: ", message)
    }
}

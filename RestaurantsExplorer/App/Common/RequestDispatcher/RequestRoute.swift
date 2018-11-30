//
//  RequestRoute.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get, post
}

enum RequestRoute {
    
    static let zomatoAPIHeaders: [String: String] = [
        "user_key": Config.zomatoAPIToken,
        "Accept": "application/json"
    ]
    
    case searchCity(term: String)
    
    var path: String {
        switch self {
        case .searchCity(let term):
            return "https://developers.zomato.com/api/v2.1/cities?q=\(term)"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .searchCity:
            return RequestRoute.zomatoAPIHeaders
        }
    }
    
    var method: String {
        switch self {
        case .searchCity:
            return RequestMethod.get.rawValue
        }
    }
    
    var params: Any? {
        return nil
    }
}

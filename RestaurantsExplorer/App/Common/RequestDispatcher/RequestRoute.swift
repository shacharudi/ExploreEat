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
    case searchRestaurants(cityId: String)
    case getRestaurntDetails(restaurntId: String)
    
    var path: String {
        switch self {
        case .searchCity(let term):
            return "https://developers.zomato.com/api/v2.1/cities?q=\(term)"
        case .searchRestaurants(let cityId):
            return "https://developers.zomato.com/api/v2.1/search?entity_id=\(cityId)&entity_type=city"
        case .getRestaurntDetails(let restaurntId):
            return "https://developers.zomato.com/api/v2.1/restaurant?res_id=\(restaurntId)"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .searchCity, .searchRestaurants, .getRestaurntDetails:
            return RequestRoute.zomatoAPIHeaders
        }
    }
    
    var method: String {
        switch self {
        case .searchCity, .searchRestaurants, .getRestaurntDetails:
            return RequestMethod.get.rawValue
        }
    }
    
    var params: Any? {
        return nil
    }
}

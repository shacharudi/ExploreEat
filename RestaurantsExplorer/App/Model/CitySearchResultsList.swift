//
//  CitySearchResults.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import SwiftyJSON

struct City {
    private struct Keys {
        static let countryName = "country_name"
        static let cityName = "name"
        static let countryFlagImageUrl = "country_flag_url"
    }
    
    let countryName: String
    let cityName: String
    let countryFlagImageUrl: String
    
    init(json: JSON) {
        self.countryName = json[City.Keys.countryName].stringValue
        self.cityName = json[City.Keys.cityName].stringValue
        self.countryFlagImageUrl = json[City.Keys.countryFlagImageUrl].stringValue
    }

}

class CitySearchResultsList {
    static let kLocationSuggestionsKey = "location_suggestions"
    
    let cities: [City]
    
    init(cities: [City]) {
        self.cities = cities
    }
}

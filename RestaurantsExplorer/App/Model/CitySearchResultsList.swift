//
//  CitySearchResults.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import SwiftyJSON

class City: ModelType {
    private struct Keys {
        static let cityId = "id"
        static let countryName = "country_name"
        static let cityName = "name"
        static let countryFlagImageUrl = "country_flag_url"
    }
    
    @objc dynamic var cityId: String = ""
    @objc dynamic var countryName: String = ""
    @objc dynamic var cityName: String = ""
    @objc dynamic var countryFlagImageUrl: String = ""
    
    override static func primaryKey() -> String? {
        return "cityId"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.cityId = json[City.Keys.cityId].stringValue
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

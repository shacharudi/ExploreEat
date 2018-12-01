//
//  RestaurntsSearchResultsList.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import SwiftyJSON

class Restaurnt: ModelType {
    private struct Keys {
        static let restaurant = "restaurant"
        static let restaurantId = "id"
        static let name = "name"
        static let url = "url"
        static let location = "location"
        static let address = "address"
        static let city = "city"
        static let cityId = "city_id"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let cuisines = "cuisines"
    }
    
    @objc dynamic var restaurantId = ""
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    @objc dynamic var address = ""
    @objc dynamic var city = ""
    @objc dynamic var cityId = ""
    @objc dynamic var latitude = ""
    @objc dynamic var longitude = ""
    @objc dynamic var cuisines = ""
    
    override static func primaryKey() -> String? {
        return "restaurantId"
    }
    
    convenience init(json: JSON) {
        self.init()
        
        let restaurant = json[Restaurnt.Keys.restaurant]
        self.restaurantId = restaurant[Restaurnt.Keys.restaurantId].stringValue
        self.name = restaurant[Restaurnt.Keys.name].stringValue
        self.url = restaurant[Restaurnt.Keys.url].stringValue
        self.cuisines = restaurant[Restaurnt.Keys.cuisines].stringValue
        
        let location = restaurant[Restaurnt.Keys.location]
        self.address = location[Restaurnt.Keys.address].stringValue
        self.city = location[Restaurnt.Keys.city].stringValue
        self.cityId = location[Restaurnt.Keys.cityId].stringValue
        self.latitude = location[Restaurnt.Keys.latitude].stringValue
        self.longitude = location[Restaurnt.Keys.longitude].stringValue
    }
}

class RestaurntsSearchResultsList {
    static let kRestaurntsKey = "restaurants"
    let restaurnts: [Restaurnt]
    init(restaurnts: [Restaurnt]) {
        self.restaurnts = restaurnts
    }
}

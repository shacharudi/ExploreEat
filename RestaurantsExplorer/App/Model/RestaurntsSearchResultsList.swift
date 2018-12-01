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
    
    static let restaurantKey = "restaurant"
    
    private struct Keys {
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
        static let featuredImage = "featured_image"
        static let priceRange = "price_range"
        static let currency = "currency"
    }
    
    @objc dynamic var restaurantId = ""
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    @objc dynamic var address = ""
    @objc dynamic var city = ""
    @objc dynamic var cityId = ""
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var cuisines = ""
    @objc dynamic var featuredImage = ""
    @objc dynamic var priceRange = -1
    @objc dynamic var currency = ""

    override static func primaryKey() -> String? {
        return "restaurantId"
    }
    
    convenience init(restaurant: JSON) {
        self.init()
        
        self.restaurantId = restaurant[Restaurnt.Keys.restaurantId].stringValue
        self.name = restaurant[Restaurnt.Keys.name].stringValue
        self.url = restaurant[Restaurnt.Keys.url].stringValue
        self.cuisines = restaurant[Restaurnt.Keys.cuisines].stringValue
        self.currency = restaurant[Restaurnt.Keys.currency].stringValue
        self.priceRange = restaurant[Restaurnt.Keys.priceRange].intValue
        self.featuredImage = restaurant[Restaurnt.Keys.featuredImage].stringValue

        let location = restaurant[Restaurnt.Keys.location]
        self.address = location[Restaurnt.Keys.address].stringValue
        self.city = location[Restaurnt.Keys.city].stringValue
        self.cityId = location[Restaurnt.Keys.cityId].stringValue
        self.latitude = location[Restaurnt.Keys.latitude].doubleValue
        self.longitude = location[Restaurnt.Keys.longitude].doubleValue
    }
}

class RestaurntsSearchResultsList {
    static let kRestaurntsKey = "restaurants"
    let restaurnts: [Restaurnt]
    init(restaurnts: [Restaurnt]) {
        self.restaurnts = restaurnts
    }
}

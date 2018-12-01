//
//  CityMapVCViewModel.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation

protocol CityMapVCViewModelDelegate: class {
    func updateViewDetails(city: City)
}

class CityMapVCViewModel {
    
    public weak var delegate: CityMapVCViewModelDelegate?
    
    private let cityId: String
    private let database: DatabaseType
    
    init(cityId: String, database: DatabaseType) {
        self.cityId = cityId
        self.database = database
    }
    
    public func viewLoad() {
        self.loadCity()
    }
    
    private func loadCity() {
        guard let city = self.database.getCityById(cityId: self.cityId) else {
            Logger.error(message: "Can't find city with id: \(cityId) in database!")
            return
        }
        self.delegate?.updateViewDetails(city: city)
    }
}

//
//  CityMapVCViewModel.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import Hydra
import RxCocoa
import RxSwift

protocol CityMapVCViewModelDelegate: class {
    func updateViewDetails(city: City)
    func setMapRestaurnts(restaurntsSearchResults: RestaurntsSearchResultsList)
}

protocol CityMapVCViewModelType {
    var loadingState: Variable<AsyncLoadingState> { get }
    
    func viewLoaded()
}

class CityMapVCViewModel: CityMapVCViewModelType {
    
    public weak var delegate: CityMapVCViewModelDelegate?
    public var loadingState = Variable<AsyncLoadingState>(.loading)
    
    private let cityId: String
    private let database: DatabaseType
    private let searchRestaurntsService: SearchRestaurntsServiceType

    init(cityId: String, database: DatabaseType, searchRestaurntsService: SearchRestaurntsServiceType) {
        self.cityId = cityId
        self.database = database
        self.searchRestaurntsService = searchRestaurntsService
    }
    
    public func viewLoaded() {
        self.loadCity()
        self.loadCityRestaurnts()
    }
    
    private func loadCity() {
        guard let city = self.database.getCityById(cityId: self.cityId) else {
            Logger.error(message: "Can't find city with id: \(cityId) in database!")
            return
        }
        self.delegate?.updateViewDetails(city: city)
    }
    
    private func loadCityRestaurnts() {
        self.searchRestaurntsService.searchRestaurnts(cityId: self.cityId)
            .then { [weak self] searchResults in
                self?.delegate?.setMapRestaurnts(restaurntsSearchResults: searchResults)
        }
    }
}

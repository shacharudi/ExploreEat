//
//  HomeVCViewModel.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit
import Hydra
import RxCocoa
import RxSwift

protocol HomeVCViewModelType {
    var viewTitle: String { get }
    var tableSectionTitle: String { get }
    var searchState: Variable<AsyncSearchState> { get }
    var citySearchResults: Variable<CitySearchResultsList?> { get }
    
    func showPreviousSearches()
    func searchTermChanged(term: String)
    func saveSelectedCity(city: City)
}

class HomeVCViewModel: HomeVCViewModelType {

    public var viewTitle: String = Texts.homeVCViewTitle
    public var tableSectionTitle = Texts.searchCityNoPreviousSearches
    public var searchState = Variable<AsyncSearchState>(.emptyTerm)
    public var citySearchResults = Variable<CitySearchResultsList?>(nil)
    
    private let searchLocationsService: SearchLocationsServiceType
    private let database: DatabaseType
    
    init(searchLocationsService: SearchLocationsServiceType, database: DatabaseType) {
        self.searchLocationsService = searchLocationsService
        self.database = database
    }
    
    public func searchTermChanged(term: String) {
        self.searchState.value = .searching
        self.searchLocationsService.searchLocation(term: term)
            .then { [weak self] searchResults in
                self?.searchReturned(searchResults: searchResults)
        }
    }
    
    public func showPreviousSearches() {
        self.citySearchResults.value = CitySearchResultsList(cities: [])
    }
    
    public func saveSelectedCity(city: City) {
        self.database.saveSelectedCity(city: city)
    }
    
    private func searchReturned(searchResults: CitySearchResultsList) {
        self.citySearchResults.value = searchResults
        if searchResults.cities.isEmpty {
            self.searchState.value = .noResults
        } else {
            self.searchState.value = .hasResults
        }
    }
}

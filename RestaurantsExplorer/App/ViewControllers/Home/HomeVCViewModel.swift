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
    var searchState: Variable<AsyncLoadingState> { get }
    var citySearchResults: Variable<CitySearchResultsList?> { get }
    
    func viewLoaded()
    func searchDismissed()
    func searchWillPresent()
    func searchTermChanged(term: String)
    func saveSelectedCity(city: City)
}

class HomeVCViewModel: HomeVCViewModelType {

    public var viewTitle: String = Texts.homeVCViewTitle
    public var tableSectionTitle = Texts.searchCityNoPreviousSearches
    public var searchState = Variable<AsyncLoadingState>(.emptyTerm)
    public var citySearchResults = Variable<CitySearchResultsList?>(nil)
    
    private let searchLocationsService: SearchLocationsServiceType
    private let database: DatabaseType
    
    init(searchLocationsService: SearchLocationsServiceType, database: DatabaseType) {
        self.searchLocationsService = searchLocationsService
        self.database = database
    }
    
    public func searchTermChanged(term: String) {
        guard !term.isEmpty else {
            let emptyResults = CitySearchResultsList(cities: [])
            self.searchReturned(searchResults: emptyResults)
            return
        }
        self.searchState.value = .loading
        self.searchLocationsService.searchLocation(term: term)
            .then { [weak self] searchResults in
                self?.searchReturned(searchResults: searchResults)
        }
    }
    
    public func searchDismissed() {
        self.showPreviousSearches()
    }
    
    public func searchWillPresent() {
        self.searchTermChanged(term: "")
    }
    
    public func saveSelectedCity(city: City) {
        self.database.saveSelectedCity(city: city)
    }
    
    public func viewLoaded() {
        self.showPreviousSearches()
    }
    
    private func searchReturned(searchResults: CitySearchResultsList) {
        
        print(searchResults.cities)
        self.citySearchResults.value = searchResults
        
        if searchResults.cities.isEmpty {
            self.searchState.value = .noResults
        } else {
            self.searchState.value = .hasResults
        }
    }
    
    private func showPreviousSearches() {
        let cities = self.database.getPreviousSearches()
        self.citySearchResults.value = CitySearchResultsList.init(cities: cities)
        self.searchState.value = .hasResults
    }
}

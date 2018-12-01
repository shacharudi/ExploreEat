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
}

class HomeVCViewModel: HomeVCViewModelType {

    public var viewTitle: String = Texts.homeVCViewTitle
    public var tableSectionTitle = Texts.searchCityNoPreviousSearches
    public var searchState = Variable<AsyncSearchState>(.emptyTerm)
    public var citySearchResults = Variable<CitySearchResultsList?>(nil)
    
    private let searchLocationsService: SearchLocationsServiceType
    
    init(searchLocationsService: SearchLocationsServiceType) {
        self.searchLocationsService = searchLocationsService
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
    
    private func searchReturned(searchResults: CitySearchResultsList) {
        
        self.citySearchResults.value = searchResults
        
        if searchResults.cities.isEmpty {
            self.searchState.value = .noResults
        } else {
            self.searchState.value = .hasResults
        }
    }
}

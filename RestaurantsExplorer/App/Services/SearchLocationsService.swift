//
//  SearchLocationsService.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import Hydra
import SwiftyJSON

protocol SearchLocationsServiceType {
    func searchLocation(term: String) -> Promise<CitySearchResultsList>
}

class SearchLocationsService: SearchLocationsServiceType {
    
    private let requestDispatcher: RequestDispatcherType
    
    init(requestDispatcher: RequestDispatcherType) {
        self.requestDispatcher = requestDispatcher
    }
    
    public func searchLocation(term: String) -> Promise<CitySearchResultsList> {
        return Promise<CitySearchResultsList> { resolve, reject, _ in
            let parser = self.createSearchParser()
            self.requestDispatcher.dispatch(RequestRoute.searchCity(term: term), parser: parser)
                .then { searchResults in
                    resolve(searchResults)
                }.catch { error in
                    reject(error)
            }
        }
    }
    
    private func createSearchParser() -> RequestResponseParser<CitySearchResultsList> {
        let parser = RequestResponseParser<CitySearchResultsList>
            .create(parseBlock: { (parsed: JSON) -> CitySearchResultsList in
                var cities = [City]()
                parsed[CitySearchResultsList.kLocationSuggestionsKey].array?.forEach { cityJSON in
                    cities.append(City(json: cityJSON))
                }
                return CitySearchResultsList.init(cities: cities)
            })
        return parser
    }
}

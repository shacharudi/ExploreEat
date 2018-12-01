//
//  SearchRestaurntsService.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import Hydra
import SwiftyJSON

protocol SearchRestaurntsServiceType {
    func searchRestaurnts(cityId: String) -> Promise<RestaurntsSearchResultsList>
}

class SearchRestaurntsService: SearchRestaurntsServiceType {
    
    private let requestDispatcher: RequestDispatcherType
    
    init(requestDispatcher: RequestDispatcherType) {
        self.requestDispatcher = requestDispatcher
    }
    
    public func searchRestaurnts(cityId: String) -> Promise<RestaurntsSearchResultsList> {
        return Promise<RestaurntsSearchResultsList> { resolve, reject, _ in
            let parser = self.createSearchParser()
            self.requestDispatcher.dispatch(RequestRoute.searchRestaurants(cityId: cityId), parser: parser)
                .then { searchResults in
                    resolve(searchResults)
                }.catch { error in
                    reject(error)
            }
        }
    }
    
    private func createSearchParser() -> RequestResponseParser<RestaurntsSearchResultsList> {
        let parser = RequestResponseParser<RestaurntsSearchResultsList>
            .create(parseBlock: { (parsed: JSON) -> RestaurntsSearchResultsList in
                var restaurnts = [Restaurnt]()
                parsed[RestaurntsSearchResultsList.kRestaurntsKey].array?.forEach { restaurntJSON in
                    restaurnts.append(Restaurnt(json: restaurntJSON))
                }
                return RestaurntsSearchResultsList.init(restaurnts: restaurnts)
            })
        return parser
    }
}

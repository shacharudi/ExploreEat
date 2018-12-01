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
    func getRestaurntDetails(restaurntId: String) -> Promise<Restaurnt>
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
    
    public func getRestaurntDetails(restaurntId: String) -> Promise<Restaurnt> {
        return Promise<Restaurnt> { resolve, reject, _ in
            let parser = self.createGetRestaurntDetailsParser()
            self.requestDispatcher.dispatch(RequestRoute.getRestaurntDetails(restaurntId: restaurntId), parser: parser)
                .then { restaurnt in
                    resolve(restaurnt)
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
                    restaurnts.append(Restaurnt(restaurant: restaurntJSON[Restaurnt.restaurantKey]))
                }
                return RestaurntsSearchResultsList.init(restaurnts: restaurnts)
            })
        return parser
    }
    
    private func createGetRestaurntDetailsParser() -> RequestResponseParser<Restaurnt> {
        let parser = RequestResponseParser<Restaurnt>
            .create(parseBlock: { (parsed: JSON) -> Restaurnt in
                return Restaurnt(restaurant: parsed)
            })
        return parser
    }
}

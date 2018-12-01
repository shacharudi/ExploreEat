//
//  RestaurantDetailsVCViewModel.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import Hydra
import RxCocoa
import RxSwift

protocol RestaurantDetailsVCViewModelDelegate: class {
    func setRestaurntDetails(restaurnt: Restaurnt)
}

protocol RestaurantDetailsVCViewModelType: class {
    var delegate: RestaurantDetailsVCViewModelDelegate? { get set }
    var loadingState: Variable<AsyncLoadingState> { get }
    
    func viewLoaded()
}

class RestaurantDetailsVCViewModel: RestaurantDetailsVCViewModelType {
    
    public weak var delegate: RestaurantDetailsVCViewModelDelegate?
    public var loadingState = Variable<AsyncLoadingState>(.loading)
    
    private let restaurntId: String
    private let searchRestaurntsService: SearchRestaurntsServiceType
    
    init(restaurntId: String, searchRestaurntsService: SearchRestaurntsServiceType) {
        self.restaurntId = restaurntId
        self.searchRestaurntsService = searchRestaurntsService
    }
    
    public func viewLoaded() {
        self.loadRestaurnt()
    }
    
    private func loadRestaurnt() {
        self.searchRestaurntsService.getRestaurntDetails(restaurntId: self.restaurntId)
            .then { [weak self] restaurnt in
                self?.resturantDetailsReturned(restaurnt: restaurnt)
        }
    }
    
    private func resturantDetailsReturned(restaurnt: Restaurnt) {
        self.delegate?.setRestaurntDetails(restaurnt: restaurnt)
    }
}

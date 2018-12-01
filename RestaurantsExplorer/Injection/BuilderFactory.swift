//
//  BuilderFactory.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class Factory {
    weak var container: Container!
    init(container: Container) {
        self.container = container
    }
}

class CityMapFactory: Factory {
    func create(cityId: String) -> CityMapVC {
        self.container.autoregister(
            CityMapVCViewModel.self, argument: String.self, initializer: CityMapVCViewModel.init
        )
        let viewModel = self.container.resolve(CityMapVCViewModel.self, argument: cityId)!
        self.container.autoregister(CityMapVC.self, argument: CityMapVCViewModel.self, initializer: CityMapVC.init)
        return self.container.resolve(CityMapVC.self, argument: viewModel)!
    }
}

class RestaurntDetailsVCFactory: Factory {
    func create(restaurntId: String) -> RestaurantDetailsVC {
        self.container.autoregister(
            RestaurantDetailsVCViewModel.self, argument: String.self, initializer: RestaurantDetailsVCViewModel.init
        )
        
        let viewModel = self.container.resolve(RestaurantDetailsVCViewModel.self, argument: restaurntId)!
        self.container.autoregister(
            RestaurantDetailsVC.self,
            argument: RestaurantDetailsVCViewModel.self,
            initializer: RestaurantDetailsVC.init
        )
        return self.container.resolve(RestaurantDetailsVC.self, argument: viewModel)!
    }
}

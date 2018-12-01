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

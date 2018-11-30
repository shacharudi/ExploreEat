//
//  AppBuilder.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class AppBuilder {
    private let container = Container()
    
    public func buildApp() {
        self.container.register(Container.self) { [unowned self] _ in
            return self.container
        }
        self.registerViewControllers()
        self.registerViewModels()
    }
    
    public func rootViewController() -> UIViewController {
        return self.container.resolve(AppContainerVC.self)!
    }
    
    private func registerViewControllers() {
        self.container.autoregister(AppContainerVC.self, initializer: AppContainerVC.init).inObjectScope(.container)
        self.container.autoregister(HomeVC.self, initializer: HomeVC.init)
    }
    
    private func registerViewModels() {
        self.container.autoregister(HomeVCViewModel.self, initializer: HomeVCViewModel.init)
    }
}

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
        
        self.registerNavigationControllers()
        self.registerViewControllers()
        self.registerViewModels()
        self.registerServices()
        self.registerInteractors()
        self.registerFactory()
    }
    
    public func rootViewController() -> UIViewController {
        return self.container.resolve(AppContainerVC.self)!
    }
    
    private func registerNavigationControllers() {
        self.container.autoregister(MainNavigationController.self, initializer: MainNavigationController.init)
    }
    
    private func registerViewControllers() {
        self.container.autoregister(AppContainerVC.self, initializer: AppContainerVC.init).inObjectScope(.container)
        self.container.autoregister(HomeVC.self, initializer: HomeVC.init)
    }
    
    private func registerViewModels() {
        self.container.autoregister(HomeVCViewModelType.self, initializer: HomeVCViewModel.init)
    }
    
    private func registerServices() {
        self.container.autoregister(SearchLocationsServiceType.self, initializer: SearchLocationsService.init)
    }
    
    private func registerInteractors() {
        self.container.autoregister(RequestDispatcherType.self, initializer: RequestDispatcher.init)
    }
    
    private func registerFactory() {
        self.container.autoregister(CityMapFactory.self, initializer: CityMapFactory.init)
    }
}

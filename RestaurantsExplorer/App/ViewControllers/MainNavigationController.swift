//
//  MainNavigationController.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    private let homeVC: HomeVC
    
    init(homeVC: HomeVC) {
        self.homeVC = homeVC
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers([self.homeVC], animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

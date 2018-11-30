//
//  HomeVCViewModel.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit

protocol HomeVCViewModelType {
    var viewTitle: String { get }
}

class HomeVCViewModel: HomeVCViewModelType {
    
    public var viewTitle: String = Texts.homeVCViewTitle
    
    init() {
        
    }
}

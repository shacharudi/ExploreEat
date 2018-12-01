//
//  CityMapVC.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import UIKit

class CityMapVC: UIViewController {

    private let viewModel: CityMapVCViewModel
    
    init(cityVCViewModel: CityMapVCViewModel) {
        self.viewModel = cityVCViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
}

//
//  CityMapVC.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import UIKit

class CityMapVC: UIViewController, CityMapVCViewModelDelegate {

    private let viewModel: CityMapVCViewModel
    private let cityDetailsView = CityDetailsView()
    
    init(cityVCViewModel: CityMapVCViewModel) {
        self.viewModel = cityVCViewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.viewModel.viewLoad()
    }
    
    private func setupView() {
        self.view.backgroundColor = Colors.viewControllerBackground
        self.setupCityDetails()
    }
    
    // MARK: - CityDetailsView
    
    private func setupCityDetails() {
        self.view.addSubview(self.cityDetailsView)
        self.cityDetailsView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets.zero, excludingEdge: .bottom)
        self.cityDetailsView.autoSetDimension(.height, toSize: CityDetailsView.ViewStyle.viewHeight)
    }
    
    // MARK: - CityMapVCViewModelDelegate
    
    func updateViewDetails(city: City) {
        self.cityDetailsView.setViewCity(city: city)
    }
}

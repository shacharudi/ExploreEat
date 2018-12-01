//
//  CityMapVC.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import PureLayout

class CityMapVC: UIViewController, CityMapVCViewModelDelegate {

    private let viewModel: CityMapVCViewModel
    private let cityDetailsView = CityDetailsView()
    private let loadingView = LoadingContentView()
    private let cityMap = LocationsMap()

    private let disposeBag = DisposeBag()
    
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
        self.viewModel.viewLoaded()
    }
    
    private func setupView() {
        self.view.backgroundColor = Colors.viewControllerBackground
        self.setupCityDetails()
        self.setupLoadingView()
        self.setupCityMap()
    }
    
    // MARK: - Loading View
    
    private func setupLoadingView() {
        self.view.addSubview(self.loadingView)
        self.loadingView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        self.loadingView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
        self.bindLoadingView()
    }
    
    private func bindLoadingView() {
        self.viewModel.loadingState.asObservable().subscribe { [weak self] event in
            if let isState = event.element {
                self?.loadingState(loadingState: isState)
            }
            }.disposed(by: self.disposeBag)
    }
    
    private func loadingState(loadingState: AsyncLoadingState) {
        switch loadingState {
        case .emptyTerm, .noResults, .hasResults:
            self.loadingView.isHidden = true
        case .loading:
            self.loadingView.isHidden = false
        }
    }
    
    // City Map
    
    private func setupCityMap() {
        self.view.addSubview(self.cityMap)
        self.cityMap.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets.zero, excludingEdge: .top)
        self.cityMap.autoPinEdge(.top, to: .bottom, of: self.cityDetailsView)
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
    
    func setMapRestaurnts(restaurntsSearchResults: RestaurntsSearchResultsList) {
        
    }
}

//
//  RestaurantDetailsVC.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import PureLayout

class RestaurantDetailsVC: UIViewController, RestaurantDetailsVCViewModelDelegate {
    
    private let viewModel: RestaurantDetailsVCViewModelType
    private let loadingView = LoadingContentView()

    private let disposeBag = DisposeBag()
    
    init(restaurntDetailsViewModel: RestaurantDetailsVCViewModelType) {
        self.viewModel = restaurntDetailsViewModel
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
        self.setupLoadingView()
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
    
    // MARK: - RestaurantDetailsVCViewModelDelegate
    
    func setRestaurntDetails(restaurnt: Restaurnt) {
        print(restaurnt)
    }
}

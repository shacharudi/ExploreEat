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
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let cityLabel = UILabel()
    private let addressLabel = UILabel()
    private let cuisinesLabel = UILabel()
    private let linkButton = UIButton()
    
    private var imageHeightConstraint: NSLayoutConstraint?
    
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
        self.setupDetailsUI()
    }
    
    private func setupDetailsUI() {
        self.addUISubviews()
        self.layoutUISubviews()
        self.styleSubviews()
    }
    
    private func addUISubviews() {
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.cityLabel)
        self.view.addSubview(self.addressLabel)
        self.view.addSubview(self.cuisinesLabel)
        self.view.addSubview(self.linkButton)
    }
    
    // MARK: - Layout Subviews
    
    private func layoutUISubviews() {
        self.layoutImageView()
        self.layoutTitleLabel()
        self.layoutCouisinsLabel()
        self.layoutAddressLabel()
        self.layoutCityNameLabel()
    }
    
    private func layoutCityNameLabel() {
        self.cityLabel.autoPinEdge(.top, to: .bottom, of: self.addressLabel, withOffset: Metrics.padding)
        self.cityLabel.autoPinEdge(.left, to: .left, of: self.view, withOffset: Metrics.padding)
        self.cityLabel.autoPinEdge(.right, to: .right, of: self.view, withOffset: Metrics.padding)
    }
    
    private func layoutAddressLabel() {
        self.addressLabel.autoPinEdge(.top, to: .bottom, of: self.cuisinesLabel, withOffset: Metrics.paddingPlus)
        self.addressLabel.autoPinEdge(.left, to: .left, of: self.view, withOffset: Metrics.padding)
        self.addressLabel.autoPinEdge(.right, to: .right, of: self.view, withOffset: Metrics.padding)
    }
    
    private func layoutCouisinsLabel() {
        self.cuisinesLabel.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: Metrics.smallPadding)
        self.cuisinesLabel.autoPinEdge(.left, to: .left, of: self.view, withOffset: Metrics.padding)
        self.cuisinesLabel.autoPinEdge(.right, to: .right, of: self.view, withOffset: Metrics.padding)
    }
    
    private func layoutTitleLabel() {
        self.titleLabel.autoPinEdge(.top, to: .bottom, of: self.imageView, withOffset: Metrics.paddingPlus)
        self.titleLabel.autoPinEdge(.left, to: .left, of: self.view, withOffset: Metrics.padding)
        self.titleLabel.autoPinEdge(.right, to: .right, of: self.view, withOffset: Metrics.padding)
    }
    
    private func layoutImageView() {
        self.imageView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        self.imageView.autoPinEdge(toSuperviewEdge: .left)
        self.imageView.autoPinEdge(toSuperviewEdge: .right)
        self.imageHeightConstraint = self.imageView.autoSetDimension(
            .height, toSize: Metrics.RestaurntDetails.imageHeight
        )
    }
    
    // MARK: - Style Subviews
    
    private func styleSubviews() {
        self.titleLabel.font = Fonts.RestaurntDetailsView.title
        self.cuisinesLabel.font = Fonts.RestaurntDetailsView.cuisins
        self.addressLabel.font = Fonts.RestaurntDetailsView.address
        self.cityLabel.font = Fonts.RestaurntDetailsView.city
        
        self.titleLabel.textColor = Colors.primaryColor
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
        self.title = restaurnt.name
        self.setRestaurntImage(featuredImage: restaurnt.featuredImage)
        self.setTitle(name: restaurnt.name, priceRange: restaurnt.priceRange, currency: restaurnt.currency)
        self.setCouisins(couisins: restaurnt.cuisines)
        self.setAddress(address: restaurnt.address)
        self.setCityName(cityName: restaurnt.city)
    }
    
    private func setRestaurntImage(featuredImage: String) {
        if featuredImage.isEmpty {
            self.imageHeightConstraint?.constant = 0
        } else {
            self.imageHeightConstraint = self.imageView.autoSetDimension(
                .height, toSize: Metrics.RestaurntDetails.imageHeight
            )
            Images.setImage(
                imageView: self.imageView,
                urlString: featuredImage,
                defaultImage: UIImage.from(color: Colors.textWhite)
            )
        }
        self.imageView.layoutIfNeeded()
    }
    
    private func setTitle(name: String, priceRange: Int, currency: String) {
        let price = String(repeating: currency.first ?? "$", count: priceRange)
        self.titleLabel.text = "\(name) \(price)"
    }
    
    private func setCouisins(couisins: String) {
        self.cuisinesLabel.text = couisins
    }
    
    private func setAddress(address: String) {
        self.addressLabel.text = address
    }
    
    private func setCityName(cityName: String) {
        self.cityLabel.text = cityName
    }
}

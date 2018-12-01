//
//  CityDetailsView.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class CityDetailsView: UIView {
    
    enum ViewStyle {
        static let viewHeight: CGFloat = 64
        static let flagSize = CGSize(width: 50, height: 50)
        static let flagCornetRadius: CGFloat = 4
    }
    
    private let countryFlag = UIImageView()
    private let cityName = UILabel()
    private let countryName = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup view Content
    
    public func setViewCity(city: City) {
        self.cityName.text = city.cityName
        self.countryName.text = city.countryName
        Images.setImage(
            imageView: self.countryFlag,
            urlString: city.countryFlagImageUrl,
            defaultImage: DefaultImage.noCountryFlag
        )
    }
    
    // MARK: - Setting up view UI
    
    private func setupView() {
        self.addSubviews()
        self.layoutUISubviews()
        self.styleSubviews()
    }
    
    private func addSubviews() {
        self.addSubview(self.countryFlag)
        self.addSubview(self.cityName)
        self.addSubview(self.countryName)
    }
    
    private func layoutUISubviews() {
        self.countryFlag.autoSetDimensions(to: ViewStyle.flagSize)
        self.countryFlag.autoPinEdge(.left, to: .left, of: self, withOffset: Metrics.padding)
        self.countryFlag.autoPinEdge(.top, to: .top, of: self, withOffset: Metrics.padding)
        
        self.cityName.autoPinEdge(
            .left, to: .right, of: self.countryFlag, withOffset: Metrics.smallPadding
        )
        self.cityName.autoPinEdge(
            .top, to: .top, of: self, withOffset: Metrics.paddingPlus
        )
        
        self.countryName.autoPinEdge(
            .left, to: .right, of: self.countryFlag, withOffset: Metrics.smallPadding
        )
        self.countryName.autoPinEdge(
            .top, to: .bottom, of: self.cityName, withOffset: 0
        )
    }
    
    private func styleSubviews() {
        self.cityName.font = Fonts.CitySearchCell.cityName
        self.countryName.font = Fonts.CitySearchCell.countryName
        
        self.cityName.textColor = Colors.CitySearchCell.cityName
        self.countryName.textColor = Colors.CitySearchCell.countryName
        
        self.countryFlag.contentMode = .scaleAspectFit
        self.countryFlag.layer.cornerRadius = ViewStyle.flagCornetRadius
        
        self.addBottomBorder()
    }
}

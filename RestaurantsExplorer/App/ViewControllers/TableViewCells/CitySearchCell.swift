//
//  CitySearchCell.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import UIKit
import PureLayout

class CitySearchCell: UITableViewCell {

    static let identifier = "CitySearchCellIdentifier"
    
    private let countryFlag = UIImageView()
    private let cityName = UILabel()
    private let countryName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup Cell Content
    
    public func setCellCity(city: City) {
        self.cityName.text = city.cityName
        self.countryName.text = city.countryName
        Images.setImage(
            imageView: self.countryFlag,
            urlString: city.countryFlagImageUrl,
            defaultImage: DefaultImage.noCountryFlag
        )
    }
    
    // MARK: - Setup Cell UI
    
    private func setupCell() {
        self.addSubviews()
        self.layoutUISubviews()
        self.styleSubviews()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.countryFlag)
        self.contentView.addSubview(self.cityName)
        self.contentView.addSubview(self.countryName)
    }
    
    private func layoutUISubviews() {
        self.countryFlag.autoSetDimensions(to: Metrics.SearchCityCell.flagSize)
        self.countryFlag.autoPinEdge(.left, to: .left, of: self.contentView, withOffset: Metrics.SearchCityCell.padding)
        self.countryFlag.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: Metrics.SearchCityCell.padding)
        
        self.cityName.autoPinEdge(
            .left, to: .right, of: self.countryFlag, withOffset: Metrics.SearchCityCell.smallPadding
        )
        self.cityName.autoPinEdge(
            .top, to: .top, of: self.contentView, withOffset: Metrics.SearchCityCell.padding
        )
        
        self.countryName.autoPinEdge(
            .left, to: .right, of: self.countryFlag, withOffset: Metrics.SearchCityCell.smallPadding
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
        self.countryFlag.layer.cornerRadius = Metrics.SearchCityCell.flagCornetRadius
    }
}

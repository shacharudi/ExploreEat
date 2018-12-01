//
//  HomeVC+TableView.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cities = self.viewModel.citySearchResults.value?.cities else {
            return 0
        }
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.SearchCityCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CitySearchCell.identifier,
            for: indexPath
        ) as? CitySearchCell else {
            Logger.error(message: "Can't dequeueReusableCell at row index: \(indexPath.row)")
            return UITableViewCell()
        }
        
        guard let city = self.viewModel.citySearchResults.value?.cities[indexPath.row] else {
            Logger.error(message: "Can't get city at row index: \(indexPath.row)")
            return cell
        }
        cell.setCellCity(city: city)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = self.viewModel.citySearchResults.value?.cities[indexPath.row] else {
            Logger.error(message: "Can't select city at row index: \(indexPath.row)")
            return
        }
        self.didSelectCity(city: city)
    }
}

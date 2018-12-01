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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        let titleLabel = UILabel()
        sectionHeader.addSubview(titleLabel)

        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 0))
        titleLabel.font = Fonts.tableSectionTitle
        titleLabel.textColor = Colors.sectionTitle
        titleLabel.text = self.viewModel.tableSectionTitle
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 //Metrics.searchCitySectionHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()        
        return cell
    }
}

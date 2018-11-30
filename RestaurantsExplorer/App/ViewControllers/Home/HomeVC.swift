//
//  HomeVC.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    private let viewModel: HomeVCViewModelType
    private let searchController = UISearchController.init(searchResultsController: nil)
    
    init(viewModel: HomeVCViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // MARK: - View Setup
    
    private func setupView() {
        self.view.backgroundColor = Colors.viewControllerBackground
        self.title = self.viewModel.viewTitle
        
        self.setupNavigationButtons()
        self.setupNavigationSearch()
    }
    
    private func setupNavigationButtons() {
        let plusButton = UIBarButtonItem.init(
            image: Icons.plusIcon,
            style: .plain, target: self,
            action: #selector(self.tappedPlusButton)
        )
        self.navigationItem.rightBarButtonItem  = plusButton
    }
    
    private func setupNavigationSearch() {
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.placeholder = Texts.homeVCSearchTitle
        self.navigationItem.searchController = self.searchController
    }
    
    // MARK: - Navigation Actions
    
    @objc private func tappedPlusButton() {
        
    }
}

extension HomeVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchTerm = searchController.searchBar.text else {
            return
        }  
    }
}

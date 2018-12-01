//
//  HomeVC.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import PureLayout

class HomeVC: UIViewController {

    internal let viewModel: HomeVCViewModelType
    
    private let tableView = UITableView()
    private let searchController = UISearchController.init(searchResultsController: nil)
    private let disposeBag = DisposeBag()
    
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
        self.setupTableView()
        self.setupNavigationSearch()
    }
    
    private func setupTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        self.tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
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
        self.searchController.searchBar.placeholder = Texts.homeVCSearchTitle
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.barTintColor = Colors.navigationBar
        self.tableView.tableHeaderView = searchController.searchBar
        self.bindSearch()
    }
    
    private func bindSearch() {
        self.searchController.searchBar
        .rx.text
        .orEmpty
        .debounce(0.3, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .subscribe(onNext: { [weak self] searchTerm in
            self?.viewModel.searchTermChanged(term: searchTerm)
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: - Navigation Actions
    
    @objc private func tappedPlusButton() {
        
    }
}

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
    private let loadingView = LoadingContentView()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: HomeVCViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.hidesSearchBarWhenScrolling = true
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
        self.setupLoadingView()
        self.setupNavigationSearch()
    }
    
    // MARK: - Loading View
    
    private func setupLoadingView() {
        self.view.addSubview(self.loadingView)
        self.loadingView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        self.loadingView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
        self.bindLoadingView()
    }
    
    private func bindLoadingView() {
        self.viewModel.searchState.asObservable().subscribe { [weak self] event in
            if let isState = event.element {
                self?.searchStateChanged(searchState: isState)
            }
        }.disposed(by: self.disposeBag)
    }
    
    private func searchStateChanged(searchState: AsyncSearchState) {
        switch searchState {
        case .emptyTerm:
            self.viewModel.showPreviousSearches()
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
        case .hasResults:
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
        case .noResults:
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
        case .searching:
            self.tableView.isHidden = true
            self.loadingView.isHidden = false
        }
    }
    
    // MARK: - Table View
    
    private func setupTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        self.tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
    }
    
    // MARK: - Navigation Bar
    
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
        self.navigationItem.searchController = searchController
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

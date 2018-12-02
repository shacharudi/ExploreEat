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
    private let cityMapFactory: CityMapFactory
    private let database: DatabaseType
    
    private let tableView = UITableView()
    private let searchController = UISearchController.init(searchResultsController: nil)
    private let loadingView = LoadingContentView()
    
    private let disposeBag = DisposeBag()
    private var canceledSearch = false
    
    init(
        viewModel: HomeVCViewModelType,
        cityMapFactory: CityMapFactory,
        database: DatabaseType
    ) {
        self.viewModel = viewModel
        self.cityMapFactory = cityMapFactory
        self.database = database
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
        
        self.viewModel.viewLoaded()
    }
    
    // MARK: - Loading View
    
    private func setupLoadingView() {
        self.view.addSubview(self.loadingView)
        self.loadingView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        self.loadingView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
        self.bindLoadingView()
    }
    
    private func bindLoadingView() {
        self.viewModel.searchState.asObservable().skip(1).subscribe { [weak self] event in
            if let isState = event.element {
                // next: make sure results show, write a test, add app icon
                self?.searchStateChanged(searchState: isState)
            }
        }.disposed(by: self.disposeBag)
    }
    
    private func searchStateChanged(searchState: AsyncLoadingState) {
        switch searchState {
        case .emptyTerm:
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
        case .hasResults:
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
        case .noResults:
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
        case .loading:
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
        self.tableView.register(CitySearchCell.self, forCellReuseIdentifier: CitySearchCell.identifier)
        self.bindTableSearchResults()
        self.definesPresentationContext = true
    }
    
    private func bindTableSearchResults() {
        self.viewModel.citySearchResults.asObservable().subscribe { [weak self] event in
            if event.element != nil {
                self?.searchResulstsChanged()
            }
        }.disposed(by: self.disposeBag)
    }
    
    private func searchResulstsChanged() {
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation Bar
    
    private func setupNavigationButtons() {
        let plusButton = UIBarButtonItem.init(
            image: Icons.trashIcon,
            style: .plain, target: self,
            action: #selector(self.tappedTrashIcon)
        )
        self.navigationItem.rightBarButtonItem  = plusButton
    }
    
    private func setupNavigationSearch() {
        self.searchController.searchBar.placeholder = Texts.homeVCSearchTitle
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.barTintColor = Colors.navigationBar
        self.searchController.searchBar.tintColor = Colors.textWhite
        
        self.searchController.delegate = self
        self.navigationItem.searchController = searchController
        self.bindSearch()
    }
    
    private func bindSearch() {
        self.searchController.searchBar
        .rx.text
        .orEmpty
        .skip(1)
        .debounce(0.3, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .subscribe(onNext: { [weak self] searchTerm in
            guard self?.canceledSearch == false else {
                self?.canceledSearch = false
                return
            }
            self?.viewModel.searchTermChanged(term: searchTerm)
        }).disposed(by: self.disposeBag)
        
        self.searchController.searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] _ in
                self?.canceledSearch = true
            }).disposed(by: self.disposeBag)
    }
    
    // MARK: - Navigation Actions
    
    @objc private func tappedTrashIcon() {
        let options = AlertPresentorOptions(
            titie: Texts.TrashSearchesAlert.title,
            message: Texts.TrashSearchesAlert.message,
            okTitle: Texts.TrashSearchesAlert.okButton,
            cancelTitle: Texts.TrashSearchesAlert.cancelButton,
            okHandler: self.onClearPreviousSearches, cancelHandler: nil,
            onVC: self
        )
        AlertPresentor.showAlert(options: options)
    }
    
    @objc func onClearPreviousSearches() {
        self.viewModel.clearPrevoiusSearches()
    }
    
    // MARK: - Presenting City Map
    
    internal func didSelectCity(city: City) {
        self.viewModel.saveSelectedCity(city: city)
        self.presentCityMap(city: city)
    }
    
    private func presentCityMap(city: City) {
        let cityMapVC = self.cityMapFactory.create(cityId: city.cityId)
        self.navigationController?.pushViewController(cityMapVC, animated: true)
    }
}

extension HomeVC: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        self.viewModel.searchWillPresent()
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        self.viewModel.searchDismissed()
    }
}

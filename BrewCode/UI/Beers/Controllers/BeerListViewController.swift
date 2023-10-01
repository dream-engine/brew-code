//
//  BeerListViewController.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import UIKit

protocol BeerListViewControllerProtocol: AnyObject {
    // CollectionView Data
    func item(atIndexPath indexPath: IndexPath) -> Any
    func numberOfRows(inSection section: Int) -> Int
    func headerItem(atSection section: Int) -> Any?
    var numberOfSections: Int { get }
    var screenMode: BeerListScreenMode { get }
    
    func fetchBeers()
    
    func didSelect(filter: String)
    func didUpdate(favourite isFavourite: Bool, forId id: Int64)
    func updateScreen(withMode mode: BeerListScreenMode)
    func didUpdateSearch(withText text: String)
}

/// BeerListViewController
/// To show list of beers
class BeerListViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var closeSearchButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataImage: UIImageView!
    
    // MARK: Properties
    
    /// ViewModel
    /// For data fetching and processing
    var viewModel: BeerListViewControllerProtocol!
    let refreshControl = UIRefreshControl()

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.setupPullToRefresh()
        self.setupViewModel()
        self.viewModel.fetchBeers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.setupGradient()
        }
    }

}

// MARK: Helper Functions
extension BeerListViewController {
    
    private func setupUI() {
        self.tableView.backgroundColor = .clear
        self.view.backgroundColor = .white
        
        self.favouriteButton.layer.cornerRadius = 6
        self.favouriteButton.backgroundColor = .white
        
        self.searchButton.layer.cornerRadius = 6
        self.searchButton.backgroundColor = .white
        
        self.searchBar.isHidden = true
        self.closeSearchButton.isHidden = true
        
        self.showNoDataView(withBool: false)
    }
    
    /// Setup View Model
    private func setupViewModel() {
        self.viewModel = BeerListViewModel(view: self)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerCell(BeerListCell.self)
        self.tableView.registerHeaderFooter(BeerSegmentHeaderCell.self)
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        gradientLayer.frame = self.gradientView.bounds
        
        self.gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.viewModel.fetchBeers()
        refreshControl.endRefreshing()
    }
    
}

// MARK: IBActions
extension BeerListViewController {
    
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.viewModel.updateScreen(withMode: sender.isSelected ? .favourite : .list)
        self.titleLabel.text = self.viewModel.screenMode.title
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.favouriteButton.isSelected = false
        self.viewModel.updateScreen(withMode: sender.isSelected ? .search : .list)
        self.searchBar.isHidden = !sender.isSelected
        self.closeSearchButton.isHidden = !sender.isSelected
        if sender.isSelected {
            self.searchBar.becomeFirstResponder()
        }
        self.titleLabel.text = self.viewModel.screenMode.title
    }
    
    @IBAction func closeSearchButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.searchButton.isSelected = false
        self.viewModel.updateScreen(withMode: .list)
        self.searchBar.isHidden = true
        self.closeSearchButton.isHidden = true
        self.searchBar.resignFirstResponder()
        self.titleLabel.text = self.viewModel.screenMode.title
        self.viewModel.didUpdateSearch(withText: "")
        self.searchBar.text = ""
    }
}

// MARK: BeerListViewModelProtocol
extension BeerListViewController: BeerListViewModelProtocol {
    /// Reload Data
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showNoDataView(withBool show: Bool) {
        DispatchQueue.main.async {
            self.noDataView.isHidden = !show
            self.searchButton.isHidden = show
            self.favouriteButton.isHidden = show
            self.noDataImage.image = UIImage(systemName: self.viewModel.screenMode.emptyDataImageName)
            switch self.viewModel.screenMode {
            case .list:
                ()
            case .favourite:
                self.searchButton.isHidden = false
                self.favouriteButton.isHidden = false
            case .search:
                self.searchButton.isHidden = false
                self.favouriteButton.isHidden = true
                
            }
        }
    }
}

// MARK: UITableViewDelegate
extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = self.viewModel.item(atIndexPath: indexPath) as? BeerListCellModel,
           let vc = BeerDetailViewController.newInstance {
            vc.setupViewModel(withBeer: item.beer)
            vc.popDelegate = self
            self.showDetailViewController(vc, sender: self)
        }
    }
}

// MARK: UITableViewDataSource
extension BeerListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let identifier = self.reuseIdentifier(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell else {
                return UITableViewCell()
        }
        cell.delegate = self
        cell.item = self.viewModel?.item(atIndexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    private func reuseIdentifier(at indexPath: IndexPath) -> String? {
        let item = self.viewModel?.item(atIndexPath: indexPath)
        switch item {
        case _ as BeerListCellModel:
            return BeerListCell.reuseIdentifier
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerModel = self.viewModel.headerItem(atSection: section) {
            let identifier = BeerSegmentHeaderCell.reuseIdentifier
            guard let headerView =  tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? TableHeaderFooterView else {return UIView()}
            headerView.item = headerModel
            headerView.delegate = self
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.viewModel.headerItem(atSection: section) != nil {
            return 50
        } else {
            return 0
        }
    }
}

// MARK: BeerSegmentHeaderCellProtocol
extension BeerListViewController: BeerSegmentHeaderCellProtocol {
    func didSelect(filter: String) {
        self.viewModel.didSelect(filter: filter)
    }
}


// MARK: BeerListCellProtocol
extension BeerListViewController: BeerListCellProtocol {
    func didUpdate(favourite isFavourite: Bool, forId id: Int64) {
        self.viewModel.didUpdate(favourite: isFavourite, forId: id)
    }
}

// MARK: BeerDetailViewControllerPopProtocol
extension BeerListViewController: BeerDetailViewControllerPopProtocol {
    func didPop() {
        self.viewModel.fetchBeers()
    }
}

// MARK: UISearchBarDelegate
extension BeerListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.didUpdateSearch(withText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    
}

//
//  BeerListViewController.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import UIKit

protocol BeerListViewControllerProtocol {
    // CollectionView Data
    func item(atIndexPath indexPath: IndexPath) -> Any
    func numberOfRows(inSection section: Int) -> Int
    func headerItem(atSection section: Int) -> Any?
    var numberOfSections: Int { get }
    
    func fetchBeers()
    
    func didSelect(filter: String)
}

/// BeerListViewController
/// To show list of beers
class BeerListViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: UIView!
    
    // MARK: Properties
    
    /// ViewModel
    /// For data fetching and processing
    var viewModel: BeerListViewControllerProtocol!

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
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
    }
    
    /// Setup View Model
    private func setupViewModel() {
        self.viewModel = BeerListViewModel(view: self)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerCell(BeerPagingHeaderCell.self)
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
    
}

// MARK: BeerListViewModelProtocol
extension BeerListViewController: BeerListViewModelProtocol {
    /// Reload Data
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

// MARK: UICollectionViewDelegate
extension BeerListViewController: UITableViewDelegate {
    
}

// MARK: UICollectionViewDataSource
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
//        return UITableViewCell()
    }
    
    private func reuseIdentifier(at indexPath: IndexPath) -> String? {
        let item = self.viewModel?.item(atIndexPath: indexPath)
        switch item {
        case _ as BeerListCellModel:
            return BeerListCell.reuseIdentifier
        case _ as BeerPagingHeaderCellModel:
            return BeerPagingHeaderCell.reuseIdentifier
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = BeerSegmentHeaderCell.reuseIdentifier
        guard let headerView =  tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? TableHeaderFooterView else {return UIView()}
        headerView.item = self.viewModel.headerItem(atSection: section)
        headerView.delegate = self
        return headerView
    }
}

// MARK: BeerSegmentHeaderCellProtocol
extension BeerListViewController: BeerSegmentHeaderCellProtocol {
    func didSelect(filter: String) {
        self.viewModel.didSelect(filter: filter)
    }
}

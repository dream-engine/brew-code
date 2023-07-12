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
    var numberOfSections: Int { get }
    
    func fetchBeers()
}

/// BeerListViewController
/// To show list of beers
class BeerListViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    /// ViewModel
    /// For data fetching and processing
    var viewModel: BeerListViewControllerProtocol!

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupViewModel()
        self.viewModel.fetchBeers()
    }

}

// MARK: Helper Functions
extension BeerListViewController {
    
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
        return cell
//        return UITableViewCell()
    }
    
    private func reuseIdentifier(at indexPath: IndexPath) -> String? {
        let item = self.viewModel?.item(atIndexPath: indexPath)
        switch item {
        case _ as BeerListCellModel:
            return BeerListCell.reuseIdentifier
        default: return nil
        }
    }
}

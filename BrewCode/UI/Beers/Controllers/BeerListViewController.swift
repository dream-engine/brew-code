//
//  BeerListViewController.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import UIKit

protocol BeerListViewControllerProtocol {
    
}

/// BeerListViewController
/// To show list of beers
class BeerListViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    /// ViewModel
    /// For data fetching and processing
    var viewModel: BeerListViewControllerProtocol!

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }

}

// MARK: Helper Functions
extension BeerListViewController {
    
    /// Setup View Model
    private func setupViewModel() {
        self.viewModel = BeerListViewModel(view: self)
    }
    
}

// MARK: BeerListViewModelProtocol
extension BeerListViewController: BeerListViewModelProtocol {
    /// Reload Data
    func reload() {
        self.collectionView.reloadData()
    }
}

//
//  BeerListViewController.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import UIKit

protocol BeerListViewControllerProtocol {
    
    func item(atIndexPath indexPath: IndexPath) -> Any
    func numberOfRows(inSection section: Int) -> Int
    var numberOfSections: Int { get }
    
    
    func fetchBeers()
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
        self.setupCollectionView()
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
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

// MARK: BeerListViewModelProtocol
extension BeerListViewController: BeerListViewModelProtocol {
    /// Reload Data
    func reload() {
        self.collectionView.reloadData()
    }
}

// MARK: UICollectionViewDelegate
extension BeerListViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension BeerListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

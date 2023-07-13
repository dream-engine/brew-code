//
//  BeerDetailViewController.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//

import UIKit

protocol BeerDetailViewControllerPopProtocol: AnyObject {
    func didPop()
}

// MARK: BeerDetailViewControllerProtocol
protocol BeerDetailViewControllerProtocol: AnyObject {
    var imageUrlString: String? { get }
    var title: String { get }
    var tagline: String { get }
    var description: String { get }
    var contributor: String { get }
    var brewerTips: String { get }
    var isFavourite: Bool { get }
    var malts: String { get }
    var hops: String { get }
    
    func didUpdate(favourite: Bool)
}

// MARK: BeerDetailViewController
class BeerDetailViewController: UIViewController {
    
    static var newInstance: BeerDetailViewController? {
        let sb = UIStoryboard.init(name: Storyboard.beers.name,
                                   bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: self.className()) as? BeerDetailViewController
        return vc
    }
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var beerImageView: ImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var taglineLable: UILabel!
    @IBOutlet weak var maltsLable: UILabel!
    @IBOutlet weak var hopsLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var contributorLable: UILabel!
    @IBOutlet weak var brewerTipsLable: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    var viewModel: BeerDetailViewControllerProtocol!
    weak var popDelegate: BeerDetailViewControllerPopProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.updateView()
    }

}

// MARK: Helper Functions
extension BeerDetailViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .clear
        self.backgroundView.backgroundColor = .clear
        
        self.closeButton.backgroundColor = .white
        self.favouriteButton.backgroundColor = .white
        self.backgroundView.addBlur(withStyle: .prominent, andCornerRadius: 0.0)
        
        self.closeButton.layer.cornerRadius = 32
        self.favouriteButton.layer.cornerRadius = 32
        
        self.titleLable.font = .boldSystemFont(ofSize: 20)
    }
    
    func setupViewModel(withBeer beer: Any) {
        self.viewModel = BeerDetailViewModel(view: self, beer: beer)
    }
    
    func updateView() {
        self.favouriteButton.isSelected = self.viewModel.isFavourite
        self.titleLable.text = self.viewModel.title
        self.contributorLable.text = self.viewModel.contributor
        self.hopsLable.text = self.viewModel.hops
        self.maltsLable.text = self.viewModel.malts
        self.descriptionLable.text = self.viewModel.description
        print(self.viewModel.malts)
        print(self.viewModel.hops)
        if let urlString = self.viewModel.imageUrlString,
           let url = URL(string: urlString) {
            beerImageView.setImageFromUrl(
                url: url,
                placeHolder: UIImage(named: "beer_placeholder")
            )
        }
    }
}

// MARK: IBActions
extension BeerDetailViewController {
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.popDelegate?.didPop()
        }
    }
    
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.viewModel.didUpdate(favourite: sender.isSelected)
    }
}

// MARK: BeerDetailViewModelProtocol
extension BeerDetailViewController: BeerDetailViewModelProtocol {
    
}

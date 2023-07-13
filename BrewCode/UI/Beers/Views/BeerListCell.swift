//
//  BeerListCell.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 12/07/23.
//

import UIKit

protocol BeerListCellProtocol: AnyObject {
    func didUpdate(favourite isFavourite: Bool, forId id: Int64)
}

class BeerListCell: TableViewCell {
    
    @IBOutlet weak var beerImageView: ImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundBlurView: UIView!
    @IBOutlet weak var isFavouriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.beerImageView.image = UIImage(named: "beer_placeholder")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.containerView.backgroundColor = .clear
        
        self.beerNameLabel.textColor = .white
        self.tagLineLabel.textColor = .lightGray
        
        self.containerView.layer.cornerRadius = 12
        self.containerView.backgroundColor = .clear
        
        self.backgroundBlurView.layer.cornerRadius = 12
        self.backgroundBlurView.backgroundColor = .clear
        self.backgroundBlurView.addBlur(withStyle: .systemThinMaterialDark, andCornerRadius: 12)
        
    }
    
    override func configure(_ item: Any?) {
        if let item = self.item as? BeerListCellModel {
            self.beerNameLabel.text = item.name
            self.tagLineLabel.text = item.tagline
            self.isFavouriteButton.isSelected = item.isFavourite
            if let urlString = item.imageUrlString,
               let url = URL(string: urlString) {
                self.beerImageView
                    .setImageFromUrl(
                        url: url,
                        placeHolder: UIImage(named: "beer_placeholder")
                    )
            }
        }
    }
    
    @IBAction func isFavouriteButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if let delegate = self.delegate as? BeerListCellProtocol,
           let item = self.item as? BeerListCellModel {
            delegate.didUpdate(favourite: sender.isSelected, forId: item.beer.id)
            item.beer.isFavourite = sender.isSelected
        }
    }
    
}

//
//  BeerListCell.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 12/07/23.
//

import UIKit

class BeerListCell: TableViewCell {
    
    @IBOutlet weak var beerImageView: ImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

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
//        self.setupGradient()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.containerView.backgroundColor = .clear
    }
    
    override func configure(_ item: Any?) {
        if let item = self.item as? BeerListCellModel {
            self.beerNameLabel.text = item.beer.name
            if let url = URL(string: item.beer.imageURL) {
                self.beerImageView
                    .setImageFromUrl(
                        url: url,
                        placeHolder: UIImage(named: "beer_placeholder")
                    )
            }
        }
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

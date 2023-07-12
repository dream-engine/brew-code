//
//  BeerListCell.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 12/07/23.
//

import UIKit

class BeerListCell: TableViewCell {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    private func setupUI() {
        
    }
    
    override func configure(_ item: Any?) {
        if let item = self.item as? BeerListCellModel {
            self.beerNameLabel.text = item.beer.name
            self.beerImageView.image = UIImage(data: try! Data(contentsOf: URL(string: item.beer.imageURL)!))
        }
    }
    
}

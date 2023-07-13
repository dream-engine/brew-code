//
//  BeerSegmentCollectionCell.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//

import UIKit

class BeerSegmentCollectionCell: CollectionViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    override func configure(_ item: Any?) {
        if let item = self.item as? BeerSegmentCollectionCellModel {
            self.titleLable.text = item.title
            self.containerView.backgroundColor = item.containerBackgroundColor
            self.titleLable.textColor = item.titleColor
        }
    }
}

// MARK: Helper functions
extension BeerSegmentCollectionCell {
    private func setupUI() {
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.titleLable.font = .boldSystemFont(ofSize: 18)
        self.titleLable.textColor = .black
        self.containerView.backgroundColor = .lightGray
        self.containerView.layer.cornerRadius = 6
        
    }
}

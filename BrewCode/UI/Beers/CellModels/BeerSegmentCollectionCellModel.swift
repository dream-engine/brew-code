//
//  BeerSegmentCollectionCellModel.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//

import UIKit

class BeerSegmentCollectionCellModel {
    var title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
    
    var containerBackgroundColor: UIColor {
        return self.isSelected
        ? UIColor.darkGray
        : UIColor.lightGray
    }
    
    var titleColor: UIColor {
        return self.isSelected
        ? UIColor.white
        : UIColor.black
    }
}

//
//  BeerDetailViewModel.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//

import Foundation

// MARK: BeerDetailViewModelProtocol
protocol BeerDetailViewModelProtocol: AnyObject {
    
}

// MARK: BeerDetailViewModel
class BeerDetailViewModel {
    weak var view: BeerDetailViewModelProtocol?
    
    var beer: Beer?
    
    init(view: BeerDetailViewModelProtocol, beer: Any) {
        self.view = view
        self.beer = beer as? Beer
    }
}

// MARK: BeerDetailViewControllerProtocol
extension BeerDetailViewModel: BeerDetailViewControllerProtocol {
    
    var imageUrlString: String? {
        return self.beer?.imageUrl
    }
    
    var title: String {
        return self.beer?.name ?? ""
    }
    
    var tagline: String {
        return self.beer?.tagline ?? ""
    }
    
    var description: String {
        return self.beer?.descript ?? ""
    }
    
    var contributor: String {
        return self.beer?.contributedBy ?? ""
    }
    
    var brewerTips: String {
        return self.beer?.brewersTips ?? ""
    }
    
    var isFavourite: Bool {
        return self.beer?.isFavourite ?? false
    }
    
    func didUpdate(favourite: Bool) {
        CoreDataManager.shared.updateFavourite(withFavourite: favourite, forId: self.beer?.id ?? 0)
    }
    
    var malts: String {
        var tempStr = ""
        
        (self.beer?.ingredients?.malt ?? [])?.forEach({ malt in
            tempStr += "\n\((malt as? Malt)?.name ?? "")"
        })
        return tempStr
    }
    
    var hops: String {
        var tempStr = ""
        
        (self.beer?.ingredients?.hops ?? [])?.forEach({ hop in
            tempStr += "\n\((hop as? Hop)?.name ?? "")"
        })
        return tempStr
    }
    
}

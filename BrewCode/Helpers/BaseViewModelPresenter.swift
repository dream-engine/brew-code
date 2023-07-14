//
//  BaseViewModelPresenter.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 14/07/23.
//

import UIKit

protocol BaseViewModelPresenter: AnyObject {
    func showNoInternetToast(withMessage message: String)
    func hideNoInternetToast()
}

extension UIViewController: BaseViewModelPresenter {
    func showNoInternetToast(withMessage message: String) {
        
        guard self.view.subviews.filter({ $0.accessibilityIdentifier == "Toast" }).isEmpty else { return }
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        toastLabel.accessibilityIdentifier = "Toast"
        self.view.addSubview(toastLabel)
    }
    
    func hideNoInternetToast() {
        for subview in self.view.subviews where subview.accessibilityIdentifier == "Toast" {
            subview.removeFromSuperview()
        }
    }
}



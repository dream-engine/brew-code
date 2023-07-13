//
//  UIView+BlurView.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 12/07/23.
//

import UIKit

extension UIView {
    func addBlur(withStyle style: UIBlurEffect.Style, andCornerRadius cornerRadius: Double) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.subviews.forEach { view in
            view.layer.cornerRadius = cornerRadius
        }
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(blurEffectView)
    }
}

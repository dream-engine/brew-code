//
//  ImageView.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 12/07/23.
//

import Foundation
import UIKit
import Kingfisher

public class ImageView: UIImageView {
    
    let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(self.activity)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.activity.frame = self.bounds
    }
    
    public func setImageFromUrl(url: URL,
                                placeHolder: UIImage? = nil,
                                options: KingfisherOptionsInfo? = nil) {
        self.image = placeHolder
        
        var kfOptions: KingfisherOptionsInfo = [.transition(ImageTransition.fade(1))]
        if let options = options {
            kfOptions.append(contentsOf: options)
        }
        
        self.kf.setImage(with: url,
                         placeholder: placeHolder,
                         options: kfOptions,
                         progressBlock: nil) { _ in
        }
    }
    
    func startActivity() {
        var kf = self.kf
        kf.indicatorType = .activity
    }
    
    private func startLoader() {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    private func stopLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }
}


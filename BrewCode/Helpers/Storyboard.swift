//
//  Storyboard.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 13/07/23.
//

import UIKit

enum Storyboard: String {
    case beers = "Beers"
    
    var name: String {
        return self.rawValue
    }
}

extension UIViewController {
    static var storyboardId: String {
        return self.className()
    }
}

public extension NSObject {
    
    class func className() -> String {
        let className = (NSStringFromClass(self) as String).components(separatedBy: ".").last! as String
        return className
    }
    
    func className() -> String {
        let className = (NSStringFromClass(self.classForCoder) as String).components(separatedBy: ".").last! as String
        return className
    }
    
}

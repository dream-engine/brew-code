//
//  SwiftUIInitialViewController.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 22/07/23.
//

import UIKit
import SwiftUI

class SwiftUIInitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSwiftUIView(view: BeerListView())
    }
    
    func addSwiftUIView(view: some View) {
        let childView = UIHostingController(rootView: view)
        addChild(childView)
        childView.view.frame = self.view.bounds
        childView.view.backgroundColor = .white
        self.view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }

}

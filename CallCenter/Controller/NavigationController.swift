//
//  NavigationController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/4/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationBar.tintColor = .mainColor
//        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainColor]
//        navigationBar.titleTextAttributes = textAttributes
        
        navigationBar.tintColor = .mainGray
        navigationBar.barTintColor = .mainColor
        navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainGray]
        navigationBar.titleTextAttributes = textAttributes
    }
}

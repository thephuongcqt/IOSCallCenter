//
//  SettingViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/26/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    var searchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupKeyboardGestureRecognizer()
        view.backgroundColor = .purple
    }
    
    override func dismissKeyBoard() {
        super.dismissKeyBoard()
        searchBar?.endEditing(true)
    }
}

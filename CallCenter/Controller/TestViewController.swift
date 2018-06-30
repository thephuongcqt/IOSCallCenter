//
//  TestViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.title = "Phòng khám "
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }
}

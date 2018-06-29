//
//  HomeViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/26/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    let searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 5, y: 5, width: 300, height: 45)
        searchBar.showsBookmarkButton = false
        searchBar.placeholder = "Tìm kiếm bệnh nhân"
        searchBar.barTintColor = .mainColor
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let todayVC = TodayViewController()
        todayVC.searchBar = self.searchBar
        let todayNavController = UINavigationController(rootViewController: todayVC)
        todayNavController.tabBarItem.image = #imageLiteral(resourceName: "icon_folder")
        todayNavController.tabBarItem.title = "Trang chủ"
        
        let historyVC = HistoryViewController()
        historyVC.searchBar = self.searchBar
        let historyNavController = UINavigationController(rootViewController: historyVC)
        historyNavController.title = "Lịch sử"
        historyNavController.tabBarItem.image = #imageLiteral(resourceName: "icon_latest")
        
        let settingVC = SettingViewController()
        settingVC.searchBar = self.searchBar
        let settingNavController = UINavigationController(rootViewController: settingVC)
        settingNavController.title = "Cài đặt"
        settingNavController.tabBarItem.image = #imageLiteral(resourceName: "icon_settings")
        
        viewControllers = [todayNavController, historyNavController, settingNavController]
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(229, 231, 234).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        tabBar.tintColor = UIColor.mainColor
        
        navigationController?.navigationBar.barTintColor = .mainColor
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.titleView = searchBar        
    }
}

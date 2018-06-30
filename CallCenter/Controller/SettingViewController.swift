//
//  SettingViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/26/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController{
    enum SECTION: Int {
        case INFORMATION = 0, LOGOUT
    }
    var settingItems: [String] = ["Cài đặt giờ làm việc", "Cài đặt lời chào", "Thay đổi thông tin", "Thay đổi logo", "Gia hạn tài khoản"]
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    //MARK: Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cài đặt phòng khám"        
        setupTableView()
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func handleLogout(){
        Data.user = nil
        Data.setUsername(value: nil)
        let appDelegate = UIApplication.shared.delegate!
        appDelegate.window??.rootViewController = UINavigationController(rootViewController: LoginController())
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == SECTION.INFORMATION.rawValue{
            return 250
        } else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == SECTION.INFORMATION.rawValue{
            let view = ClinicProfileHeader()
            view.backgroundColor = .mainGray
            if let user = Data.user{
                if let url = user.imageURL{
                    view.imageProfile.showHUD(with: "")
                    view.imageProfile.loadImageUsingCache(with: url) {
                        DispatchQueue.main.async {
                            view.imageProfile.hideHUD()
                        }
                    }
                }
                view.lblName.text = "Phòng khám \(user.clinicName ?? "")"
                view.lblPhone.text = "SĐT: \(user.phoneNumber ?? "")"
            }
            return view
        } else{
            let view = UIView()
            view.backgroundColor = .mainGray
            return view
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SECTION.INFORMATION.rawValue{
            return settingItems.count
        } else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        if indexPath.section == SECTION.INFORMATION.rawValue{
            cell.textLabel?.text = settingItems[indexPath.row]
            cell.imageView?.image = #imageLiteral(resourceName: "icon_folder")
            return cell
        } else{
            cell.textLabel?.text = "Đăng xuất tài khoản"
            cell.textLabel?.textColor = .red
            cell.imageView?.image = #imageLiteral(resourceName: "icon_profile")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SECTION.LOGOUT.rawValue{
            handleLogout()
        }
    }
}

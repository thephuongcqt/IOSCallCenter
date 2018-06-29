//
//  TodayViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/26/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    var searchBar: UISearchBar?
    var tableView: UITableView!
    
    var appointments: [Appointment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardGestureRecognizer()
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: "cellId")
        
        searchBar?.delegate = self
        tableView.delegate = self
        tableView.dataSource = self        
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let service = AppointmentService.shared
        let params = [paramClinicUsername: "hoanghoa", paramAppointmentDate: "2018-06-28"]
        
        view.showHUD(with: "Đang tải danh sách lịch hẹn")
        service.getAppointments(with: params) { (result) in
            self.view.hideHUD()
            switch result{
                case .success(let response):
                    if let isSuccess = response.success, isSuccess == true , let list = response.value{
                        self.appointments = list
                        Data.appoinmentList = list
                        self.tableView.reloadData()
                    } else if let err = response.error{
                        self.showError(message: err)
                }
                case .failure(error: let err):
                    self.showError(message: err.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        tableView.contentInset = UIEdgeInsets( top: topBarHeight + 20, left: 0, bottom: 100, right: 0)
    }
    
    override func dismissKeyBoard() {
        super.dismissKeyBoard()
        searchBar?.endEditing(true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AppointmentCell
        if let item = self.appointments?[indexPath.row]{
            cell.setPhoneNumber(phone: item.phoneNumber ?? "")
            cell.setPatientName(name: item.fullName ?? "")
            cell.setNo(no: item.no ?? 0)
            cell.setTime(time: item.appointmentTime?.toTimeString() ?? "")
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmptyOrWhitespace()){
            appointments = Data.appoinmentList
        } else{
            let search = searchText.lowercased().trimmingCharacters(in: .whitespaces)
            appointments = Data.appoinmentList?.filter({ (item) -> Bool in
                var isMatched = item.fullName?.lowercased().range(of: search) != nil || item.phoneNumber?.lowercased().range(of: search) != nil
                isMatched = isMatched || item.appointmentTime?.toTimeString().range(of: search) != nil                
                return isMatched
            })
        }
        tableView.reloadData()
    }
}

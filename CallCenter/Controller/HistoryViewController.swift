//
//  HistoryViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/26/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, DatePickerModalDelegate{
    func datePickerChanged(picker: UIDatePicker) {
        date = picker.date
    }
    var dateCell: UITableViewCell?
    var appointments: [Appointment]?
    var searchBar: UISearchBar?
    
    var tableView: UITableView = {
       var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    let refreshControl: UIRefreshControl = {
        var rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return rc
    }()
    
    var date: Date = Date() {
        didSet{
            if let cell = dateCell{
                cell.textLabel?.text = date.toDateString(with: dateFormatForAppointments)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(tableView)
        navigationItem.hidesSearchBarWhenScrolling = true
        searchBar?.delegate = self
        tableView.frame = view.bounds
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        loadAppointments()
    }
    
    override func dismissKeyBoard() {
        searchBar?.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        tableView.contentInset = UIEdgeInsets( top: topBarHeight + 20, left: 0, bottom: 100, right: 0)
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        loadAppointments()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (appointments?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            dateCell = UITableViewCell()
            dateCell!.textLabel?.text = date.toDateString(with: dateFormatForAppointments)
            return dateCell!
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AppointmentCell
            if let item = self.appointments?[indexPath.row - 1]{
                cell.setPhoneNumber(phone: item.phoneNumber ?? "")
                cell.setPatientName(name: item.fullName ?? "")
                cell.setNo(no: item.no ?? 0)
                cell.setTime(time: item.appointmentTime?.toTimeString() ?? "")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismissKeyBoard()
        if indexPath.row == 0{
            let datePickerVC = DatePickerController()
            datePickerVC.date = self.date
            datePickerVC.delegate = self
            datePickerVC.modalPresentationStyle = .overCurrentContext
            present(datePickerVC, animated: true, completion: nil)
        }
    }
    
    func loadAppointments(){
        let service = AppointmentService.shared
        let params = BaseRequest.createParamsGetAppointmentByDate(username: Data.getUsername() ?? "", date: date)
        
        view.showHUD(with: "Đang tải danh sách lịch hẹn")
        service.getAppointments(with: params as [String : Any]) { (result) in
            self.view.hideHUD()
            if self.refreshControl.isRefreshing{
                self.refreshControl.endRefreshing()
            }
            
            switch result{
            case .success(let response):
                if let isSuccess = response.success, isSuccess == true , let list = response.value{
                    self.appointments = list
                    Data.appoinmentList = list
                    if(self.searchBar?.text?.isEmptyOrWhitespace() ?? false){
                        self.tableView.reloadData()
                    } else{
                        self.searchBar(self.searchBar!, textDidChange: self.searchBar!.text ?? "")
                    }
                } else if let err = response.error{
                    self.showAlert(message: err)
                }
            case .failure(error: let err):
                self.showAlert(message: err.localizedDescription)
            }
        }
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

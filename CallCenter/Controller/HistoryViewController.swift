//
//  HistoryViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/26/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    var appointments: [Appointment]?
    var searchBar: UISearchBar?
    
    var tableView: UITableView = {
       var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var datePicker: UIDatePicker = {
        var picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardGestureRecognizer()
        view.addSubview(datePicker)
        view.addSubview(tableView)
        
        searchBar?.delegate = self
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
        loadAppointments(date: Date().yesterday)
    }
    
    override func dismissKeyBoard() {
        super.dismissKeyBoard()
        searchBar?.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: -30).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: 350).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
                    
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
    
    @objc func datePickerChanged(picker: UIDatePicker){
        loadAppointments(date: picker.date)
        print(picker.date)
    }
    
    func loadAppointments(date: Date!){
        let service = AppointmentService.shared
        let params = [paramClinicUsername: "hoanghoa", paramAppointmentDate: date.toDateString(with: dateFormatForAppointments)]
        
        view.showHUD(with: "Đang tải danh sách lịch hẹn")
        service.getAppointments(with: params as [String : Any]) { (result) in
            self.view.hideHUD()
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
                    self.showError(message: err)
                }
            case .failure(error: let err):
                self.showError(message: err.localizedDescription)
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

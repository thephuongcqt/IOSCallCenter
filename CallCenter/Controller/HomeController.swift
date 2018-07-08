//
//  HomeController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class HomeController: UIViewController{
    
    var dateCell: UITableViewCell?
    var appointments: [Appointment]?

    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        var rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return rc
    }()
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.hidesNavigationBarDuringPresentation = true
        sc.dimsBackgroundDuringPresentation = false
        sc.searchBar.sizeToFit()
        sc.searchBar.delegate = self
        sc.searchBar.placeholder = "Tìm kiếm bệnh nhân"
        sc.searchBar.tintColor = .white
        sc.searchBar.barTintColor = .mainColor
        sc.searchBar.isTranslucent = false
//        sc.searchBar.barStyle = .blackTranslucent
//        sc.searchBar.searchBarStyle = .prominent
        return sc
    }()
    
    var date: Date = Date() {
        didSet{
            updateDatePickerText()
        }
    }
    
    var btnDatePicker: UIButton?
    //MARK: - Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupTableView()
        loadAppointments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshTitle()
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    //MARK: - Handle UI
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.refreshControl = refreshControl
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func setupNavBar(){
        view.backgroundColor = .white
        self.title = "Phòng khám"
        navigationItem.searchController = searchController
        self.extendedLayoutIncludesOpaqueBars = true
        navigationItem.hidesSearchBarWhenScrolling = true
        
        let imageSetting = #imageLiteral(resourceName: "icon_settings")
        let rightButton = UIBarButtonItem(image: imageSetting, style: .plain, target: self, action: #selector(rightBarButtonSelected))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    //MARK: - Handle Event
    @objc func datePickerSelected(){
        let datePickerVC = DatePickerController()
        datePickerVC.date = self.date
        datePickerVC.delegate = self
        datePickerVC.modalPresentationStyle = .overCurrentContext
        present(datePickerVC, animated: true, completion: nil)
    }
    
    @objc func rightBarButtonSelected(){    
        let settingVC = SettingViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: backTitle, style: .plain, target: settingVC, action: nil)
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    override func dismissKeyBoard() {
        searchController.searchBar.endEditing(true)
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        self.date = Date()
        loadAppointments()
    }
    
    func updateDatePickerText(){
        let str = "Lịch khám ngày \(date.getDay()) tháng \(date.getMonth()) năm \(date.getYear())"
        btnDatePicker?.setTitle(str, for: .normal)
    }
    
    //MARK: - Handle Data
    
    func refreshTitle(){
        if let user = Data.user{
            self.title = "Phòng khám \(user.clinicName ?? "")"
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
                    if(self.searchController.searchBar.text?.isEmptyOrWhitespace() ?? false){
                        self.tableView.reloadData()
                    } else{
                        self.searchBar(self.searchController.searchBar, textDidChange: self.searchController.searchBar.text ?? "")
                    }
                } else if let err = response.error{
                    self.showAlert(message: err)
                }
            case .failure(error: let err):
                self.showAlert(message: err.localizedDescription)
            }
        }
    }
}

extension HomeController: UISearchControllerDelegate, UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar(searchBar, textDidChange: "")
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

extension HomeController: DatePickerModalDelegate{
    func onModalDismiss() {
        updateDatePickerText()
        loadAppointments()
    }
    
    func onModalDone(date: Date) {

    }
    
    func datePickerChanged(picker: UIDatePicker) {
        date = picker.date
    }
    
}

extension HomeController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let view = AppointmentTableHeader()
            view.btnDatePicker.addTarget(self, action: #selector(datePickerSelected), for: .touchUpInside)
            self.btnDatePicker = view.btnDatePicker
            updateDatePickerText()
            return view
        }
        let view = AppointmentHeader()
        view.backgroundColor = .mainGray
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return appointments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AppointmentCell
        cell.selectionStyle = .none
        if let item = self.appointments?[indexPath.row]{
            cell.setPhoneNumber(phone: item.phoneNumber ?? "")
            cell.setPatientName(name: item.fullName ?? "")
            cell.setNo(no: item.no ?? 0)
            cell.setTime(time: item.appointmentTime?.toTimeString() ?? "")
        }
        return cell
    }
}

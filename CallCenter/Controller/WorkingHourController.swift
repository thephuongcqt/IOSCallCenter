//
//  WorkingHourController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class WorkingHourController: UIViewController {

    enum Section: Int{
        case duration = 0, workingHours
    }
    
    enum Working: Int{
        case monStart = 0, monEnd, tueStart, tueEnd, wesStart, wesEnd, thuStart, thuEnd, friStart, friEnd, satStart, satEnd
    }
    
    enum Day: Int{
        case Sun = 0, Mon, Tue, Wes, Thu, Fri, Sat
    }
    
    var days = ["CN", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7"]
    
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    var selectedButton: UIButton?
    
    //MARK: Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cài đặt giờ làm việc"
        
        setupTableView()
    }
    
    //MARK: Handle UI
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.register(DurationCell.self, forCellReuseIdentifier: "durationCell")
        tableView.register(DayCell.self, forCellReuseIdentifier: "dayCell")
    }
    
    //MARK: Handle event
    @objc func onButtonSelected(button: UIButton){        
        selectedButton = button
        
        let pickerModal = DatePickerController()
        pickerModal.datePicker.datePickerMode = .time
        pickerModal.modalPresentationStyle = .overCurrentContext
        pickerModal.datePicker.locale = Locale(identifier: "en_GB")
        present(pickerModal, animated: true, completion: nil)
    }
    
    @objc func onButtonConfigManyDaysSelected(){
        let daysConfigVC = DaysConfigController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: backTitle, style: .plain, target: daysConfigVC, action: nil)
        navigationController?.pushViewController(daysConfigVC, animated: true)
    }
}

extension WorkingHourController: DatePickerModalDelegate{
    func datePickerChanged(picker: UIDatePicker) {
        
    }
    
    func onModalDismiss(picker: UIDatePicker) {
        
    }
}

extension WorkingHourController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == Section.duration.rawValue{
            return CGFloat.leastNonzeroMagnitude
        }
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == Section.duration.rawValue{
            return nil
        }
        let view = DayHeader()
        view.backgroundColor = .mainGray
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Section.duration.rawValue{
            return 1
        }
        return days.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == Section.duration.rawValue{
            return 100
        }
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Section.duration.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "durationCell", for: indexPath) as! DurationCell
            cell.btnDuration.addTarget(self, action: #selector(onButtonSelected(button:)), for: .touchUpInside)
            cell.btnDuration.tag = days.count * 2
            cell.btnConfig.addTarget(self, action: #selector(onButtonConfigManyDaysSelected), for: .touchUpInside)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayCell
        cell.lblDay.text = days[indexPath.row]
        cell.btnStart.addTarget(self, action: #selector(onButtonSelected(button:)), for: .touchUpInside)
        cell.btnStart.tag = indexPath.row * 2
        cell.btnEnd.addTarget(self, action: #selector(onButtonSelected(button:)), for: .touchUpInside)
        cell.btnEnd.tag = indexPath.row * 2 + 1
        return cell
    }
}

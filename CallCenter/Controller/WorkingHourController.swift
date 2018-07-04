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
    
    enum Day: Int{
        case Sun = 0, Mon, Tue, Wes, Thu, Fri, Sat
    }
    
    var workingHours: [WorkingHour] = {
        if let whs = Data.user?.workingHours{
            return whs
        } else{
            var whs = [WorkingHour]()
            for i in 0...6{
                var wh = WorkingHour(start: defaultStartWorking, end: defaultEndWorking, applyDate: i, isDayOff: 0)
                whs.append(wh)
            }
            return whs
        }
    }()
    
    var days = ["CN", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7"]
    var cells = [Int: DayCell]()
    var durationCell: DurationCell?
    
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    var selectedButton: UIButton?
    
    //MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cài đặt giờ làm việc"
        
        setupTableView()
    }
    
    //MARK: - Handle UI
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.register(DurationCell.self, forCellReuseIdentifier: "durationCell")
        tableView.register(DayCell.self, forCellReuseIdentifier: "dayCell")
    }
    
    //MARK: - Handle event
    @objc func onButtonSelected(button: UIButton){
        var currentTime = Date()
        let isStartWorking = button.tag % 2 == 0
        let day = button.tag / 2
        if day == days.count{
            currentTime = Data.user?.examinationDuration ?? Date()
        } else{
            let wh = getWorkingHour(day: day)
            if isStartWorking{
                currentTime = wh.startWorking ?? Date()
            } else{
                currentTime = wh.endWorking ?? Date()
            }
        }
        
        selectedButton = button
        let pickerModal = DatePickerController()
        pickerModal.delegate = self
        pickerModal.datePicker.datePickerMode = .time
        pickerModal.datePicker.date = currentTime
        pickerModal.modalPresentationStyle = .overCurrentContext
        present(pickerModal, animated: true, completion: nil)
    }
    
    @objc func onButtonConfigManyDaysSelected(){
        let daysConfigVC = DaysConfigController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: backTitle, style: .plain, target: daysConfigVC, action: nil)
        navigationController?.pushViewController(daysConfigVC, animated: true)
    }
    
    @objc func onSwitchValueChanged(sw: UISwitch){
        let day = sw.tag
        let wh = getWorkingHour(day: day)
        if wh.isDayOff == 0{
            wh.isDayOff = 1
        } else{
            wh.isDayOff = 0
        }
        updateDayCell(cell: cells[day]!, day: day)
    }
    
    //MARK: - Handle data
    func getWorkingHour(day: Int) -> WorkingHour{
        for workingHour in workingHours{
            if workingHour.applyDate == day{
                return workingHour
            }
        }
        return WorkingHour(start: defaultStartWorking, end: defaultEndWorking, applyDate: day, isDayOff: 0)
    }
    
    func updateDayCell(cell: DayCell, day: Int){
        let workingHour = getWorkingHour(day: day)
        var startTitle = workingHour.startWorking!.toWorkingTime()
        var endTitle = workingHour.endWorking!.toWorkingTime()
        if workingHour.isDayOff == 1{
            startTitle = offDayTime
            endTitle = offDayTime
        }
        cell.btnStart.setTitle(startTitle, for: .normal)
        cell.btnEnd.setTitle(endTitle, for: .normal)
    }
    
    func updateDurationCell(cell: DurationCell){
        let duration = Data.user?.examinationDuration ?? defaultDuration
        Data.user?.examinationDuration = duration
        cell.btnDuration.setTitle(duration.toWorkingTime(), for: .normal)
    }
}

extension WorkingHourController: DatePickerModalDelegate{
    func onModalDismiss() {
        
    }
    
    func onModalDone(date: Date) {
        if let button = selectedButton{
            let isStartWorking = button.tag % 2 == 0
            let day = button.tag / 2
            if day == days.count{
                Data.user?.examinationDuration = date
                updateDurationCell(cell: durationCell!)
                return
            }
            let wh = getWorkingHour(day: day)
            if isStartWorking{
                wh.startWorking = date
            } else{
                wh.endWorking = date
            }
            updateDayCell(cell: cells[day]!, day: day)
        }
    }
    
    func datePickerChanged(picker: UIDatePicker) {
        
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
            cell.selectionStyle = .none
            cell.btnDuration.addTarget(self, action: #selector(onButtonSelected(button:)), for: .touchUpInside)
            cell.btnDuration.tag = days.count * 2
            cell.btnConfig.addTarget(self, action: #selector(onButtonConfigManyDaysSelected), for: .touchUpInside)
            updateDurationCell(cell: cell)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayCell
        cell.selectionStyle = .none
        cell.lblDay.text = days[indexPath.row]
        cell.btnStart.addTarget(self, action: #selector(onButtonSelected(button:)), for: .touchUpInside)
        cell.btnStart.tag = indexPath.row * 2
        cell.btnEnd.addTarget(self, action: #selector(onButtonSelected(button:)), for: .touchUpInside)
        cell.btnEnd.tag = indexPath.row * 2 + 1
        cell.swDayOff.tag = indexPath.row
        cell.swDayOff.addTarget(self, action: #selector(onSwitchValueChanged(sw:)), for: .valueChanged)
        cells[indexPath.row] = cell
        updateDayCell(cell: cell, day: indexPath.row)
        return cell
    }
}

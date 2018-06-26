//
//  HistoryViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/26/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController{

    var tableView = UITableView()
    
    var datePicker: UIDatePicker = {
        var picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(datePicker)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 10).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: 200).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Index \(indexPath.row)"
        return cell
    }

}

//
//  DatePickerController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    
    var delegate: DatePickerModalDelegate?
    
    var datePicker: UIDatePicker = {
        var picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        return picker
    }()
    
    var modalView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var btnDone: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Xác nhận", for: .normal)
        button.addTarget(self, action: #selector(dismiss(sender:)), for: .touchUpInside)
        button.backgroundColor = .mainColor
        return button
    }()
    
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.isOpaque = false
        
        view.addSubview(modalView)
        modalView.addSubview(datePicker)
        modalView.addSubview(btnDone)
        
        datePicker.setDate(date ?? Date(), animated: true)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss(sender:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        
        modalView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 20).isActive = true
        modalView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20).isActive = true
        modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        modalView.heightAnchor.constraint(equalToConstant: 285).isActive = true
        
        datePicker.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 10).isActive = true
        datePicker.topAnchor.constraint(equalTo: modalView.topAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -10).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        btnDone.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 20).isActive = true
        btnDone.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20).isActive = true
        btnDone.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -20).isActive = true
        btnDone.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc func datePickerChanged(picker: UIDatePicker){
        self.date = picker.date
        delegate?.datePickerChanged(picker: picker)
    }
    
    @objc func dismiss(sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
}

protocol DatePickerModalDelegate {
    func datePickerChanged(picker: UIDatePicker)
}

//
//  AppointmentCell.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/28/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class AppointmentCell: UITableViewCell {
    
    var lblNo: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No"
        return label
    }()
    
    var lblName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tên: "
        return label
    }()
    
    var lblPhone: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SĐT: "
        return label
    }()
    
    var lblTime: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(lblNo)
        self.addSubview(lblName)
        self.addSubview(lblPhone)
        self.addSubview(lblTime)
        setupLayout()
    }
    
    func setupLayout(){
        lblNo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        lblNo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblNo.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        lblTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        lblTime.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        lblTime.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        lblName.leadingAnchor.constraint(equalTo: lblNo.trailingAnchor, constant: 20).isActive = true
        lblName.trailingAnchor.constraint(equalTo: lblTime.leadingAnchor, constant: -10).isActive = true
        lblName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        lblPhone.leadingAnchor.constraint(equalTo: lblName.leadingAnchor).isActive = true
        lblPhone.trailingAnchor.constraint(equalTo: lblTime.leadingAnchor, constant: -10).isActive = true
        lblPhone.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    func setPhoneNumber(phone: String){
        lblPhone.text = "SĐT: " + phone
    }
    
    func setPatientName(name: String){
        lblName.text = "Tên: " + name
    }
    
    func setNo(no: Int){
        lblNo.text = "\(no)"
    }
    
    func setTime(time: String){
        lblTime.text = time
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

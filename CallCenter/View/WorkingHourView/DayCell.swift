//
//  DayCell.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/1/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class DayCell: UITableViewCell {

    var lblDay: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Chủ nhật"
//        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    var btnStart: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("00:20:00", for: .normal)
        return button
    }()
    
    var btnEnd: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("00:20:00", for: .normal)
        return button
    }()
    
    var swDayOff: UISwitch = {
        var sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.isOn = false
        return sw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(lblDay)
        addSubview(btnStart)
        addSubview(btnEnd)
        addSubview(swDayOff)
        
        lblDay.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        lblDay.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDay.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        btnStart.leadingAnchor.constraint(equalTo: lblDay.trailingAnchor, constant: 5).isActive = true
        btnStart.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        btnStart.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btnStart.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -5).isActive = true
        
        btnEnd.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        btnEnd.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btnEnd.trailingAnchor.constraint(equalTo: swDayOff.leadingAnchor, constant: -5).isActive = true
        btnEnd.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10).isActive = true
        
        swDayOff.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        swDayOff.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        swDayOff.widthAnchor.constraint(equalToConstant: 45).isActive = true
    }
}

//
//  DurationCell.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class DurationCell: UITableViewCell {
    
    var lblTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thời gian cho một cuộc hẹn"
        return label
    }()
    
    var btnDuration: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("00:20:00", for: .normal)
        return button
    }()
    
    var btnConfig: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Cài đặt nhiều ngày", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(lblTitle)
        addSubview(btnDuration)
        addSubview(btnConfig)
        
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        btnDuration.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        btnDuration.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        btnDuration.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnDuration.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        btnConfig.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        btnConfig.topAnchor.constraint(equalTo: btnDuration.topAnchor).isActive = true
        btnConfig.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnConfig.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
}

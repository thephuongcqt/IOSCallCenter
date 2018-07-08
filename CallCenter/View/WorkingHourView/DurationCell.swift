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
        
        NSLayoutConstraint.activate([
            lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            btnDuration.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            btnDuration.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10),
            btnDuration.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -7.5),
            btnDuration.heightAnchor.constraint(equalToConstant: 50),
            
            btnConfig.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 7.5),
            btnConfig.topAnchor.constraint(equalTo: btnDuration.topAnchor),
            btnConfig.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            btnConfig.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}

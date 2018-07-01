//
//  AppointmentHeader.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class AppointmentHeader: UIView {
    
    var lblNo: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "STT"
        label.textColor = .white
        return label
    }()
    
    var lblInfo: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thông tin bệnh nhân"
        label.textColor = .white
        return label
    }()
    
    var lblTime: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Giờ khám"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(lblNo)
        addSubview(lblInfo)
        addSubview(lblTime)
        
        lblNo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        lblNo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblNo.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        lblTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        lblTime.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        lblTime.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        lblInfo.leadingAnchor.constraint(equalTo: lblNo.trailingAnchor, constant: 20).isActive = true
        lblInfo.trailingAnchor.constraint(equalTo: lblTime.leadingAnchor, constant: -10).isActive = true
        lblInfo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

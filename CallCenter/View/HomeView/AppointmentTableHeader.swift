//
//  AppointmentTableHeader.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class AppointmentTableHeader: UIView {
    
    let btnDatePicker: BaseButton = {
        var btn = BaseButton()
        btn.setTitle("Click me", for: .normal)
        btn.layer.borderWidth = 0
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = .mainColor        
        addSubview(btnDatePicker)

        
        btnDatePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        btnDatePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2).isActive = true
        btnDatePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        btnDatePicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

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
        return btn
    }()
    
//    let separator: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .white
//        return view
//    }()
    
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
//        addSubview(separator)
//
//        separator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
//        separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.5).isActive = true
//
        
        btnDatePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        btnDatePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2).isActive = true
        btnDatePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        btnDatePicker.heightAnchorConstraint = heightAnchor.constraint(equalToConstant: 50)
    }
}

//
//  DayHeader.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/1/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class DayHeader: UIView {

    var lblDay: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thứ"
        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    var lblStart: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bắt đầu"
        label.textAlignment = .center        
        //        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    var lblEnd: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kết thúc"
        label.textAlignment = .center
        //        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    var lblDayOff: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nghỉ"
        label.textAlignment = .center
        //        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(lblDay)
        addSubview(lblStart)
        addSubview(lblEnd)
        addSubview(lblDayOff)
        
        lblDay.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        lblDay.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDay.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        lblStart.leadingAnchor.constraint(equalTo: lblDay.trailingAnchor, constant: 5).isActive = true
        lblStart.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblStart.heightAnchor.constraint(equalToConstant: 45).isActive = true
        lblStart.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -5).isActive = true
        
        lblEnd.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblEnd.heightAnchor.constraint(equalToConstant: 45).isActive = true
        lblEnd.trailingAnchor.constraint(equalTo: lblDayOff.leadingAnchor, constant: -5).isActive = true
        lblEnd.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 5).isActive = true
        
        lblDayOff.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        lblDayOff.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDayOff.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

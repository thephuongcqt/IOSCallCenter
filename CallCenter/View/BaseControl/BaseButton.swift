//
//  BaseButton.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/25/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var heightAnchorConstraint: NSLayoutConstraint?
    
    func setupViews(){
        self.translatesAutoresizingMaskIntoConstraints = false
        heightAnchorConstraint = heightAnchor.constraint(equalToConstant: 45)
        heightAnchorConstraint?.isActive = true
        
//        layer.cornerRadius = 15.0
        layer.borderWidth = 1.0
//        layer.borderColor = UIColor.gray.cgColor
        layer.borderColor = UIColor.mainColor.cgColor
//
        setTitleColor(UIColor.mainColor, for: .normal)
//        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        //        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
}

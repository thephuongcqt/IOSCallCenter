//
//  BaseTextField.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/25/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
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
        layer.borderColor = UIColor.mainColor.cgColor
//        layer.borderColor = UIColor.gray.cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 20, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 20, height: bounds.height)
    }
}

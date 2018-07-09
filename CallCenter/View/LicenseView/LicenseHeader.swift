//
//  LicenseHeader.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/9/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class LicenseHeader: UIView {

    var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .mainColor
//        label.font = .boldSystemFont(ofSize: 17)
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
        backgroundColor = .mainGray
        addSubview(lblTitle)
        NSLayoutConstraint.activate([
            lblTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            lblTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}

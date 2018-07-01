//
//  ClinicProfileHeader.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/30/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class ClinicProfileHeader: UIView {
    let imageProfile: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "logo")
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.mainColor.cgColor
        return iv
    }()
    
    let lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .mainColor
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let lblPhone: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .mainColor
        label.font = UIFont.boldSystemFont(ofSize: 14)
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
        addSubview(imageProfile)
        addSubview(lblName)
        addSubview(lblPhone)
        
        imageProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageProfile.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        imageProfile.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageProfile.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        lblName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblName.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 15).isActive = true
        
        lblPhone.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblPhone.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 15).isActive = true
    }
}

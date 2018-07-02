//
//  LicenseCell.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/2/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class LicenseCell: UITableViewCell {
    var lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lblNameTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tên: "
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    var lblDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lblDescriptionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mô tả: "
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    var lblPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    var lblDuration: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){        
        addSubview(lblNameTitle)
        addSubview(lblName)
        addSubview(lblPrice)
        addSubview(lblDescriptionTitle)
        addSubview(lblDescription)
        addSubview(lblDuration)
        
        lblNameTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        lblNameTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        lblNameTitle.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        lblDescriptionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        lblDescriptionTitle.topAnchor.constraint(equalTo: lblNameTitle.bottomAnchor, constant: 10).isActive = true
        lblDescriptionTitle.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        lblName.leadingAnchor.constraint(equalTo: lblNameTitle.trailingAnchor, constant: 5).isActive = true
        lblName.topAnchor.constraint(equalTo: lblNameTitle.topAnchor).isActive = true
        lblName.trailingAnchor.constraint(equalTo: lblPrice.leadingAnchor, constant: -10).isActive = true
        
        lblPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lblPrice.topAnchor.constraint(equalTo: lblName.topAnchor).isActive = true
        
        lblDescription.leadingAnchor.constraint(equalTo: lblDescriptionTitle.trailingAnchor, constant: 5).isActive = true
        lblDescription.topAnchor.constraint(equalTo: lblDescriptionTitle.topAnchor).isActive = true
        lblDescription.trailingAnchor.constraint(equalTo: lblDuration.leadingAnchor, constant: -10).isActive = true
        
        lblDuration.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lblDuration.topAnchor.constraint(equalTo: lblDescription.topAnchor).isActive = true
    }
    
    func setLicenseName(name: String){
        lblName.text = name
    }
    
    func setLicensePrice(price: Int){
        lblPrice.text = "\((price * 1000).money)đ"
    }
    
    func setLicenseDuration(duration: Int){
        lblDuration.text = "\(duration) ngày"
    }
    
    func setLicenseDescription(description: String){
        lblDescription.text = description
    }
}

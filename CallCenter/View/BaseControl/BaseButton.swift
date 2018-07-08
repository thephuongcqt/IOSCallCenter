//
//  BaseButton.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/25/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case defaultStyle
    case borderStyle
}

class BaseButton: UIButton {
    
    var style: ButtonStyle?
    
    override var isEnabled: Bool{
        didSet{
            if isEnabled{
                setupLayout()
            } else{
                disableButton()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    init(style: ButtonStyle) {
        super.init(frame: .zero)
        self.style = style
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func disableButton(){
        if let style = self.style, style == .borderStyle{
            layer.borderColor = UIColor.lightGray.cgColor
            backgroundColor = .white
            setTitleColor(.lightGray, for: .normal)
        } else{
            layer.borderColor = UIColor.lightGray.cgColor
            backgroundColor = .lightGray
            setTitleColor(.white, for: .normal)
        }
    }
    
    func setupLayout(){
        if let style = self.style, style == .borderStyle{
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.mainColor.cgColor
            self.backgroundColor = .white
            setTitleColor(.mainColor, for: .normal)
        } else{
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.mainColor.cgColor
            self.backgroundColor = .mainColor
            setTitleColor(.white, for: .normal)
        }
    }
}

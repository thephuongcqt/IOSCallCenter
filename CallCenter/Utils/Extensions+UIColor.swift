//
//  Extensions+UIColor.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//
import UIKit

extension UIColor{
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor{
        return UIColor(r: red, g: green, b: blue)
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    static let mainColor = UIColor(hex: "2484e8")
    static let mainGreen = UIColor(hex: "0x74ad14")
    static let mainBlue = UIColor(hex: "0x74ad14")
    static let mainGray = UIColor(hex: "f4f4f4")
    static let mainDarkGray = UIColor(hex: "d3cdcb")
    static let mainBlack = UIColor(r: 0, g: 122, b: 255)
}

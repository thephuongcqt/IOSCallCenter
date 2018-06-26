//
//  Extensions+MBProgressHUD.swift
//  StudyQuizIOS
//
//  Created by Nguyen The Phuong on 12/19/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIView{
    func showHUD(with message: String){
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }
    func hideHUD(){
        MBProgressHUD.hide(for: self, animated: true)
    }
}

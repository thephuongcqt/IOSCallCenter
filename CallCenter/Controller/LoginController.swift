//
//  ViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/25/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        txtPassword.isSecureTextEntry = true
        
        btnLogin.backgroundColor = .clear
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = UIColor.gray.cgColor
        
        btnRegister.backgroundColor = .clear
        btnRegister.layer.cornerRadius = 5
        btnRegister.layer.borderWidth = 1
        btnRegister.layer.borderColor = UIColor.gray.cgColor
        
        btnLogin.tintColor = .gray
        btnRegister.tintColor = .gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


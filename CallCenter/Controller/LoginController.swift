//
//  ViewController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/25/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
        
    let loginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let txtUsername: BaseTextField = {
        let tf = BaseTextField()
        tf.placeholder = "Tên đăng nhập"
        return tf
    }()
    
    let txtPassword: BaseTextField = {
       let tf = BaseTextField()
        tf.placeholder = "Mật khẩu"
        return tf
    }()
    
    let btnLogin: BaseButton = {
        let btn = BaseButton()
        btn.setTitle("Đăng nhập", for: .normal)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    let btnRegister: BaseButton = {
        let btn = BaseButton()
        btn.setTitle("Đăng ký", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(loginView)
        loginView.addSubview(txtUsername)
        loginView.addSubview(txtPassword)
        loginView.addSubview(btnLogin)
        loginView.addSubview(btnRegister)
    }
    
    override func viewDidLayoutSubviews() {
        //The method when layout is ready for constraint
        
        loginView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 20).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20).isActive = true
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        txtUsername.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10).isActive = true
        txtUsername.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 10).isActive = true
        txtUsername.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10).isActive = true
        
        txtPassword.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10).isActive = true
        txtPassword.topAnchor.constraint(equalTo: txtUsername.bottomAnchor, constant: 10).isActive = true
        txtPassword.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10).isActive = true
        
        btnLogin.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10).isActive = true
        btnLogin.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 10).isActive = true
        btnLogin.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10).isActive = true
        
        btnRegister.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10).isActive = true
        btnRegister.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 10).isActive = true
        btnRegister.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleLogin(){
        if let username = txtUsername.text, let password = txtPassword.text, username.isEmpty == false, password.isEmpty == false{
            let service = LoginService.shared
            let params = [paramUsername: username, paramPassword: password]
            
            view.showHUD(with: "Loging in...")
            service.login(with: params, completion: { (result) in
                self.view.hideHUD()
                switch result{
                    case .success(let response):
                        if let isSuccess = response.success, isSuccess == true , let clinic = response.value{
                            
                        } else if let err = response.error{
                            self.showError(message: err)
                        }
                    case .failure(error: let err):
                        self.showError(message: err.localizedDescription)
                    }
            })
        }
    }
    
    
    
}


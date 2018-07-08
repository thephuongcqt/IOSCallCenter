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
        tf.autocapitalizationType = .none
        tf.placeholder = "Tên đăng nhập"
        return tf
    }()
    
    let txtPassword: BaseTextField = {
        let tf = BaseTextField()
        tf.placeholder = "Mật khẩu"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let btnLogin: BaseButton = {
        let btn = BaseButton()
        btn.setTitle("Đăng nhập", for: .normal)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnRegister: BaseButton = {
        let btn = BaseButton()
        btn.setTitle("Đăng ký", for: .normal)
        btn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Call Center"
        
        self.setupKeyboardGestureRecognizer()
        self.view.addSubview(loginView)
        loginView.addSubview(txtUsername)
        loginView.addSubview(txtPassword)
        loginView.addSubview(btnLogin)
        loginView.addSubview(btnRegister)
    }
    
    override func viewDidLayoutSubviews() {
        //The method when layout is ready for constraint

        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 20),
            loginView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.heightAnchor.constraint(equalToConstant: 240),
            
            txtUsername.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10),
            txtUsername.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 10),
            txtUsername.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10),
            
            txtPassword.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10),
            txtPassword.topAnchor.constraint(equalTo: txtUsername.bottomAnchor, constant: 10),
            txtPassword.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10),
            
            btnLogin.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10),
            btnLogin.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 10),
            btnLogin.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10),
            btnLogin.heightAnchor.constraint(equalToConstant: 45),
            
            btnRegister.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10),
            btnRegister.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 10),
            btnRegister.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10),
            btnRegister.heightAnchor.constraint(equalToConstant: 45)
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleLogin(){
        if let username = txtUsername.text, let password = txtPassword.text, username.isEmpty == false, password.isEmpty == false{
            let service = LoginService.shared
            let params = BaseRequest.createParamsUserLogin(username: username, password: password)
            
            view.showHUD(with: "Đang tải...")
            service.login(with: params, completion: { (result) in
                self.view.hideHUD()
                switch result{
                    case .success(let response):
                        if let isSuccess = response.success, isSuccess == true , let clinic = response.value{
                            if let username = clinic.username{
                                Data.setUsername(value: username)
                                Data.user = clinic
                                let homeVC = HomeController()
                                self.navigationController?.setViewControllers([homeVC], animated: true)
                            } else{
                                self.showAlert(message: "Đã có lỗi xảy ra khi đăng nhập, vui lòng thử lại sau")
                            }
                        } else if let err = response.error{
                            self.showAlert(message: err)
                        }
                    case .failure(error: let err):
                        self.showAlert(message: err.localizedDescription)
                    }
            })
        }
    }
    
    @objc func handleRegister(){
        let registerVC = RegisterController()
        let navController = NavigationController(rootViewController: registerVC)
        present(navController, animated: true, completion: nil)
    }
}


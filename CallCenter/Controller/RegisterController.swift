//
//  RegisterController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/4/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Đăng ký tài khoản"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Huỷ", style: .plain, target: self, action: #selector(handleCancel))
        setupLayout()
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupLayout(){
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        scrollView.contentInsetAdjustmentBehavior = .automatic
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

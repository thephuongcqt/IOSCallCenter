//
//  RegisterController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/4/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class RegisterController: UIViewController{
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let tfUsername: BaseTextField = {
        let tf = BaseTextField()
        tf.placeholder = "Tên đăng nhập (*)"
        return tf
    }()
    
    var tfEmail: BaseTextField = {
        var tf = BaseTextField()
        tf.placeholder = "Email (*)"
        return tf
    }()
    
    let tfClinicName: BaseTextField = {
        let tf = BaseTextField()
        tf.placeholder = "Tên phòng khám (*)"
        return tf
    }()
    
    let tfPhone: BaseTextField = {
        let tf = BaseTextField()
        tf.placeholder = "Số điện thoại (*)"
        return tf
    }()
    
    let tfPassword: BaseTextField = {
        let tf = BaseTextField()
        tf.placeholder = "Mật khẩu (*)"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let tfConfirmPassword: BaseTextField = {
        let tf = BaseTextField()
        tf.placeholder = "Xác nhận mật khẩu (*)"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let tfAddress: BaseTextField = {
        let tf = BaseTextField()
        tf.placeholder = "Địa chỉ"
        return tf
    }()
    
    let btnRegister: BaseButton = {
        let button = BaseButton()
        button.setTitle("Đăng ký", for: .normal)
        button.addTarget(self, action: #selector(handleRegisterButtonSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = true
        return button
    }()
    
    lazy var textFields: [BaseTextField] = [tfUsername, tfEmail, tfClinicName, tfPhone, tfPassword, tfConfirmPassword, tfAddress]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Đăng ký tài khoản"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Huỷ", style: .plain, target: self, action: #selector(handleCancel))
        
        view.addSubview(scrollView)
        setupLayout()
        setupKeyboardGestureRecognizer()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func setupLayout(){
        scrollView.frame = view.bounds
        scrollView.contentInsetAdjustmentBehavior = .automatic
        let window = UIApplication.shared.windows[0]
        scrollView.contentInset = window.safeAreaInsets

        let svWidth = scrollView.frame.width, height = CGFloat(45), spacing = CGFloat(15)
        let xPosition = CGFloat(15)
        let width = svWidth - xPosition * 2
        var yPosition = CGFloat(0)
        
        for i in 0 ..< textFields.count{
            let textField = textFields[i]
            textField.delegate = self
            textField.tag = i
            textField.translatesAutoresizingMaskIntoConstraints = true
            yPosition = spacing + (height + spacing) * CGFloat(i)
            textField.frame = CGRect(x: xPosition, y: yPosition , width: width, height: height)
            scrollView.addSubview(textField)
        }        
        yPosition += spacing + height
        btnRegister.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        scrollView.addSubview(btnRegister)
        
        yPosition += height
        scrollView.contentSize = CGSize(width: svWidth, height: yPosition)
    }
    
    // MARK: - Handle event
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleRegisterButtonSelected(){
    }
    
    // MARK: - Handle keyboard
    
    @objc func keyboardWillShow(notification: NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}

extension RegisterController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
        }
        return false
    }
}

//
//  Extensions.swift
//  ChatFirebase
//
//  Created by Nguyen The Phuong on 11/29/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

protocol AlertDelegate {
    func alertDismiss()
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    static func setStattusBarBackground(color: UIColor){
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
}

extension UIViewController{
    func setupKeyboardGestureRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, delegate: AlertDelegate?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            delegate?.alertDismiss()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        var view = self.superview
        while (view != nil && view!.isKind(of: UITableView.self) == false) {
            view = view!.superview
        }
        return view as? UITableView
    }
}

extension Formatter {
    static let moneyFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var money: String {
        return Formatter.moneyFormat.string(for: self) ?? ""
    }
}



//extension Date
//{
//    init(dateString:String) {
//        let dateStringFormatter = DateFormatter()
//        dateStringFormatter.dateFormat = dateStringFormat
//        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
//        let d = dateStringFormatter.date(from: dateString)!
//        self.init(timeInterval:0, since:d)
//    }
//}


//extension Decodable {
//    init(_ any: Any) throws {
//        let data = try JSONSerialization.data(withJSONObject: any, options: .prettyPrinted)
//        let decoder = JSONDecoder()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = dateStringFormat
//        decoder.dateDecodingStrategy = .formatted(dateFormatter)
//        self = try decoder.decode(Self.self, from: data)
//    }
//}

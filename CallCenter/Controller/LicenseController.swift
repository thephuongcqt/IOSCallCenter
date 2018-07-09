//
//  LicenseController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/2/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import Braintree
import BraintreeDropIn

class LicenseController: UITableViewController {

    var licenses: [License]?
    var selectedLicenseID: String?
    var tableHeader: LicenseHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Mua license"
        tableView.register(LicenseCell.self, forCellReuseIdentifier: "licenseCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let service = LicenseService.shared
        view.showHUD(with: "Đang tải")
        service.getLicense { (result) in
            self.view.hideHUD()
            switch result{
            case .success(let response):
                if let isSuccess = response.success, isSuccess, let list = response.value{
                    self.licenses = list
                    self.tableView.reloadData()
                } else if let err = response.error{
                    self.showAlert(message: err)
                }
            case .failure(error: let err):
                self.showAlert(message: err.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = LicenseHeader()
        tableHeader = view
        updateTableHeader()
        return view
    }

    override func numberOfSections(in tableView: UITableView) -> Int {        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return licenses?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "licenseCell", for: indexPath) as! LicenseCell
        if let licenses = licenses{
            let license = licenses[indexPath.row]
            cell.setLicenseName(name: license.name ?? "")
            cell.setLicenseDuration(duration: license.duration ?? 0)
            cell.setLicensePrice(price: license.price ?? 0)
            cell.setLicenseDescription(description: license.description ?? "")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let licenses = licenses{
            let selectedLicense = licenses[indexPath.row]
            buyLicense(license: selectedLicense)
        }
    }
    
    // MARK: - Handle UI
    
    func updateTableHeader(){
        if let view = tableHeader{
            if let expiredDate = Data.user?.expiredLicense, expiredDate > Date(){
                view.lblTitle.text = "Tài khoản khả dụng đến ngày \(expiredDate.toDateString(with: "dd/MM/yyyy"))"
            } else{
                view.lblTitle.text = "Mua license để sử dụng dịch vụ của Call Center"
            }
        }
    }
    
    // MARK: - Handle pay via paypal
    
    func buyLicense(license: License){
        selectedLicenseID = "\(license.licenseID!)"
        let service = PaymentService.shared
        view.showHUD(with: "Đang tải")
        service.getClientToken { (result) in
            self.view.hideHUD()
            switch result{
            case .success(let response):
                if let isSuccess = response.success, isSuccess, let tokenObj = response.value{
                    self.showDropIn(clientTokenOrTokenizationKey: tokenObj.clientToken)
                } else if let err = response.error{
                    self.showAlert(message: err)
                }
            case .failure(error: let err):
                self.showAlert(message: err.localizedDescription)
            }
        }
        
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            controller.dismiss(animated: true, completion: nil)
            if (error != nil) {
                self.showAlert(message: "Đã có lỗi xảy ra, vui lòng thử lại sau")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                
                if result.paymentOptionType == .payPal{
                    if let nonce = result.paymentMethod?.nonce , let username = Data.getUsername(), let licenseID = self.selectedLicenseID{
                        let params = BaseRequest.createParamsCheckOut(username: username, licenseID: licenseID, nonce: nonce)
                        self.sendNonceToServer(params: params)
                    } else {
                        self.showAlert(title: "Lỗi", message: "Đã có lỗi xảy ra khi thanh toán")
                    }
                } else{
                    self.showAlert(message: "Hiện tại hệ thống chỉ hỗ trợ thanh toán bằng Paypal, Xin vui lòng thử lại")
                }
            }
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    func sendNonceToServer(params: [String: Any]){
        let service = PaymentService.shared
        self.view.showHUD(with: "Đang tải")
        service.checkOut(params: params, completion: { (result) in
            self.view.hideHUD()
            switch result{
            case .success(let response):
                if let isSuccess = response.success, isSuccess, let user = response.value{
                    Data.user = user
                    self.showAlert(message: "Mua license thành công")
                    self.updateTableHeader()
                } else if let err = response.error{
                    self.showAlert(message: err)
                }
            case .failure(error: let err):
                self.showAlert(message: err.localizedDescription)
            }
        })
    }
}

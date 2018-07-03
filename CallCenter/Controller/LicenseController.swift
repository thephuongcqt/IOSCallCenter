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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                controller.dismiss(animated: true, completion: nil)
                if result.paymentOptionType == .payPal{
                    if let nonce = result.paymentMethod?.nonce , let username = Data.getUsername(), let licenseID = self.selectedLicenseID{
                        let params = BaseRequest.createParamsCheckOut(username: username, licenseID: licenseID, nonce: nonce)
                        let service = PaymentService.shared
                        self.view.showHUD(with: "Đang tải")
                        service.checkOut(params: params, completion: { (result) in
                            self.view.hideHUD()
                            switch result{
                            case .success(let response):
                                if let isSuccess = response.success, isSuccess{
                                    self.showAlert(message: response.value ?? "Mua license thành công")
                                } else if let err = response.error{
                                    self.showAlert(message: err)
                                }
                            case .failure(error: let err):
                                self.showAlert(message: err.localizedDescription)
                            }
                        })
                    }
                } else{
                    self.showAlert(message: "Hiện tại hệ thống chỉ hỗ trợ thanh toán bằng Paypal, Xin vui lòng thử lại")
                }
            }
        }
        self.present(dropIn!, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

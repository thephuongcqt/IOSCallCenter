//
//  LicenseController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/2/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class LicenseController: UITableViewController {

    var licenses: [License]?
    
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
        let license = licenses![indexPath.row]
        cell.setLicenseName(name: license.name ?? "")
        cell.setLicenseDuration(duration: license.duration ?? 0)
        cell.setLicensePrice(price: license.price ?? 0)
        cell.setLicenseDescription(description: license.description ?? "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
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

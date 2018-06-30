//
//  AppDelegate.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/25/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        var rootNavigationController: UINavigationController
        if let username = Data.getUsername(){
            //Move to home page when user is already logged in
            let homeVC = HomeController()
            rootNavigationController = UINavigationController(rootViewController: homeVC)
            //Refresh data
            let service = LoginService.shared
            let params = BaseRequest.createParamsUserInfo(username: username)
            
            homeVC.view.showHUD(with: "Đang tải")
            service.getUserInformation(with: params) { (result) in
                homeVC.view.hideHUD()
                switch result{
                case .success(let response):
                    if let isSuccess = response.success, isSuccess, let clinic = response.value{
                        Data.user = clinic
                        homeVC.refreshTitle()
                    } else if let err = response.error{
                        homeVC.showAlert(message: err)
                    }
                case .failure(error: let err):
                    homeVC.showAlert(message: err.localizedDescription)
                }
            }
        } else{
            //move to login page
            rootNavigationController = UINavigationController(rootViewController: LoginController())
        }
        
        window?.rootViewController = rootNavigationController
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  AppDelegate.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/25/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import Firebase
import Braintree

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        BTAppSwitch.setReturnURLScheme("phuongnt.CallCenter.payments")
//        FirebaseApp.configure()
        
        var rootNavigationController: NavigationController
        if let username = Data.getUsername(){
            //Move to home page when user is already logged in
            let homeVC = HomeController()
            rootNavigationController = NavigationController(rootViewController: homeVC)
            //Refresh data
            let service = LoginService.shared
            let params = BaseRequest.createParamsUserInfo(username: username)
            
            service.getUserInformation(with: params) { (result) in
                switch result{
                case .success(let response):
                    if let isSuccess = response.success, isSuccess, let clinic = response.value{
                        Data.user = clinic
                        homeVC.refreshTitle()
                    } else if let err = response.error{
                        print(err)
//                        homeVC.showAlert(message: err)
                    }
                case .failure(error: let err):
                    print(err)
//                    homeVC.showAlert(message: err.localizedDescription)
                }
            }
        } else{
            //move to login page
            rootNavigationController = NavigationController(rootViewController: LoginController())
        }
        
        window?.rootViewController = rootNavigationController
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("phuongnt.CallCenter.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, options: options)
        }
        return false
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


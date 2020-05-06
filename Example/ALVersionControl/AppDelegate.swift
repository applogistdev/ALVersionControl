//
//  AppDelegate.swift
//  ALVersionControl
//
//  Created by sonifex on 05/06/2020.
//  Copyright (c) 2020 sonifex. All rights reserved.
//

import UIKit
import ALVersionControl

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        ALVersionControl.shared.setup(delegate: self)
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        ALVersionControl.shared.appDidBecomeActive()
    }
}


extension AppDelegate: ALVersionControllerDelegate {
    func versionControllerAPIHandler(controller: ALVersionControl,
                                     completion: @escaping ((ALVersionControlResponse?) -> Void)) {
        
        // Version control api request. If you don't have own model, it is simple enough
        // let request = ALVersionControlRequest()

        // ! As long as you call *completion* with type of *ALVersionControlResponse* instance, all works fine.
        
        // Simulate api call
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            
            let res = ALVersionControlResponse(message: "Hey! You have a new update. You must to update.",
                                               status: .force,
                                               url: URL(string: "https://www.google.com"))
            
            completion(res)
        }
        
    }
    
    
}

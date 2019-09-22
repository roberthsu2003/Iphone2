//
//  AppDelegate.swift
//  ios1
//
//  Created by teacher on 2018/3/18.
//  Copyright © 2018年 teacher. All rights reserved.
//

import UIKit
import Firebase;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    override init() {
        super.init()
        FirebaseApp.configure();
        //上架後，不要signout
        if (try? Auth.auth().signOut()) == nil{
            print("signOut失敗");
        }
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    
    

}


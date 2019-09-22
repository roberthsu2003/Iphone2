//
//  AppDelegate.swift
//  ios1
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    override init() {
        super.init();
        FirebaseApp.configure();
        //login
        if Auth.auth().currentUser != nil {
            Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                guard let _ = result,error == nil else{
                    print("login錯誤");
                    return;
                }
                print("login成功");
                
            }
        }
        
        
        
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    
    
    
}


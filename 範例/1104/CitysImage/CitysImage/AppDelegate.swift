//
//  AppDelegate.swift
//  CitysImage
//
//  Created by 徐國堂 on 2019/11/4.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    override init() {
        super.init()
        FirebaseApp.configure()
        guard Auth.auth().currentUser == nil else{
            print("已經登入UID:\(Auth.auth().currentUser!.uid)");
            let _ = DataSource.dataSource;            
            return;
        }
        
        Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
            guard result != nil, error == nil else{
                print("失敗:\(error!.localizedDescription)")
                return
            }
            
            print("login成功")
            
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


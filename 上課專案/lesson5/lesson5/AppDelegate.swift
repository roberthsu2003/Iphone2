//
//  AppDelegate.swift
//  lesson5
//
//  Created by Robert on 2019/4/24.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    override init() {
        super.init();
        FirebaseApp.configure()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /*
        if let user = Auth.auth().currentUser{
            try! Auth.auth().signOut()
            print("已經登入了");
        }else{
            print("沒有登入");
        }
 */
        if Auth.auth().currentUser == nil{
            //Auth.auth().signInAnonymously(completion: nil)
            Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                
                if error != nil{
                    print("======================")
                    print (error!.localizedDescription)
                }
                if result != nil{
                    print(result!.user.uid);
                }else{
                    print("沒有result");
                }
            }
        }
        
        let presidentsRef = Database.database().reference(withPath: "presidents")
        presidentsRef.observeSingleEvent(of: .value) { (snapshot:DataSnapshot)  in
            if !snapshot.exists(){
              let pathString = Bundle.main.path(forResource: "PresidentList", ofType: "plist")!
              let allDic = NSDictionary(contentsOfFile: pathString) as! [String:Any]
              let presidents = allDic["presidents"] as! [[String:String]]
              presidentsRef.setValue(presidents)
            }else{
                print("遠端有資料了")
            }
            
        }
        
        
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


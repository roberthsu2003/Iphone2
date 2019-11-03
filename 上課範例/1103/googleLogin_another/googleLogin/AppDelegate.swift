//
//  AppDelegate.swift
//  googleLogin
//
//  Created by 徐國堂 on 2019/10/27.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    override init() {
        super.init()
        FirebaseApp.configure();
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)  -> Bool {
        
        do{
           try Auth.auth().signOut()
           print("登出成功");
        }catch let error as NSError{
            print("登出失敗");
            print(error.localizedDescription)
        }
 
        /*
        if (try? Auth.auth().signOut()) == nil{
            print("登出失敗");
        }
 */
        
        
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
       // return GIDSignIn.sharedInstance().handle(url,                                sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,annotation: [:])
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
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

extension AppDelegate:GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        print("error:\(error.localizedDescription)")
        return
      }
        
        let window = UIApplication.shared.windows.first
        let navigationController = window?.rootViewController as? UINavigationController
        let viewControll = navigationController?.topViewController as? ViewController
        let time = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: time) {
            UIView.animate(withDuration: 0.5) {
                viewControll?.loginView.transform = CGAffineTransform(translationX: 0, y: 175)
            }
        }
        
        

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
    
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            print("error:\(error.localizedDescription)");
            return
          }
            print("displayName=\(authResult?.user.displayName)")
            print("displayName=\(authResult?.user.email)")
        }
     
    }

}

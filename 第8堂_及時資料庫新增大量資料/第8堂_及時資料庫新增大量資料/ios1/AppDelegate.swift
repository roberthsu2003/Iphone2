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
    let fileName = "sortednames.plist";
    var authHandler:AuthStateDidChangeListenerHandle!;

    override init() {
        super.init()
        FirebaseApp.configure();
    }

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       
        authHandler = Auth.auth().addStateDidChangeListener { (auth:Auth, user:User?) in
            guard let user = user else{
                print("沒有login in");
                print("開始login in");
                Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                    guard let result = result,  error == nil else{
                        print("login 失敗");
                        return;
                    }
                    
                    print("使用者uid:\(result.user.uid)");
                    
                    Auth.auth().removeStateDidChangeListener(self.authHandler);
                    self.checkHasData();
                    
                }
                
                
               
                return;
            }
            
            print("已經login,user id = \(user.uid)");
           
            
        }
        
        
        //只有開發要使用
        //上架後，就不要使用
        
        if (try? Auth.auth().signOut()) == nil {
            print("signout 失敗");
            
        }else{
            print("signout 成功");
        }
        
        
        
       
       
    
        return true
    }
    
    func checkHasData(){
        let usernameRef = Database.database().reference(withPath: "iphone2/userName");
        usernameRef.observeSingleEvent(of: .value){
            (snapshot:DataSnapshot) -> Void in
            if !snapshot.hasChildren() {
                print("沒有資料");
                self.uploadDataToFirebase(usernameRef: usernameRef, plistName: self.fileName);
            }else{
                print("有資料");
            }
        }
    }

    func uploadDataToFirebase(usernameRef:DatabaseReference,plistName:String){
        if let fileURL = Bundle.main.url(forResource: "sortednames", withExtension: "plist"){
            guard let sortedNames = NSDictionary(contentsOf: fileURL) as? [String:[String]] else{
                print("解析Dictionary錯誤");
                return;
            }
            let queue = DispatchQueue(label: "com.roberthsu2003");
            queue.async {
                for (key,values)in sortedNames{
                    print("key是:\(key)");
                    for name in values{
                        usernameRef.child(key).childByAutoId().setValue(name);
                    }
                    
                }
                //代表毛的工作完成了，自動回身上
                DispatchQueue.main.async {
                    /*
                    if let viewController = self.window?.rootViewController as? ViewController{
                        print("取得了ViewController的參考");
                    }
 */
                }
               
            }
           
            
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication){
        
        
    }

}


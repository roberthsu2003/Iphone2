//
//  ViewController.swift
//  StorageWithPlist
//
//  Created by 徐國堂 on 2019/11/8.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var uid:String!
    let plistName = "citylist.plist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLogin()
        getPlistFile()
    }
    
    func userLogin(){
        guard let user = Auth.auth().currentUser else{
            Auth.auth().signInAnonymously { (resuld:AuthDataResult?, error:Error?) in
                guard resuld != nil, error == nil else{
                    print("暱名登入失敗");
                    return
                }
                print("暱名登入成功");
            }
            
            return
        }
        uid = user.uid
        print("uid=\(uid!)")
    }
    
    func getPlistFile(){
        //check Documents 有沒有citylist.plist
        let fileManager = FileManager.default;
        guard var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            print("url有錯誤");
            return
        }
        url.appendPathComponent(plistName)
        print(url.path);
        
        if !fileManager.fileExists(atPath: url.path){
            print("沒有citylist.plist");
            //下載公用版的plist
        }
        
        
        
        
    }
    


}




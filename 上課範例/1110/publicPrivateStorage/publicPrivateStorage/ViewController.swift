//
//  ViewController.swift
//  publicPrivateStorage
//
//  Created by 徐國堂 on 2019/11/10.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UITableViewController {
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userAuthentication();
    }
    
   
    
    func userAuthentication(){
        if Auth.auth().currentUser == nil {
                   //尚未認證
                   Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                       guard result != nil, error == nil else{
                           print("anoonymously失敗");
                           return
                       }
                    self.checkCityplistInDocuments()
                    
                   }
                 
        }else{
        //已經認證
          checkCityplistInDocuments()
        }
    }
    
    func checkCityplistInDocuments(){
        let fileManager = FileManager.default;
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            print("沒有取得documentsURL");
            return;
        }
        
        let plistURL = documentsURL.appendingPathComponent("citylist.plist")
        if !fileManager.fileExists(atPath: plistURL.path){
            let plistInStorageRef = storage.reference(withPath: "h2/citylist.plist")
            plistInStorageRef.getData(maxSize: 1*1024*1024) { (data:Data?, error:Error?) in
                guard let plistData = data, error == nil else {
                    print("下載plist檔案有錯");
                    return
                }
                do{
                   try plistData.write(to: plistURL)
                }catch let error as NSError{
                    print("寫入plist有錯:\(error.localizedDescription)")
                }
                
                
            }
        }
        
        
    }


}


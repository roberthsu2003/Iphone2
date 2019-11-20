//
//  ViewController.swift
//  googleLogin
//
//  Created by 徐國堂 on 2019/10/30.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard Auth.auth().currentUser != nil else{
            //沒有登入會執行這裏
            performSegue(withIdentifier: "goLogin", sender: nil);
            return;
        }
        //登入會執行這裏
        //print(Auth.auth().currentUser?.uid);
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = Auth.auth().currentUser else{
            //使用者尚未登入
            performSegue(withIdentifier: "goLogin", sender: nil);
            return
        }
        print("user uid:\(user.uid)");
        guard let ciytsDbURL = getCitysDbURLFromDocuments()else{
            //因為data目錄沒有Db,要下載dbFromUserId
            downloadCityFromUserIdFolder();
            return
        }
        //有citys.db
        //操作citys.db
        
        
    }
    
    func getCitysDbURLFromDocuments() -> URL?{
        let fileManager = FileManager.default
        let rootURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let dataFolderURL = rootURL.appendingPathComponent("data", isDirectory: true)
        let citysDbUrl = dataFolderURL.appendingPathComponent("citys.db")
        guard fileManager.fileExists(atPath: citysDbUrl.path) else{
            //沒有發現citys.db
            //下載citydb
            print("沒有發現city.db");
            return nil
        }
        
        return citysDbUrl
        
    }
    
    func downloadCityFromUserIdFolder(){
        
    }
    
    


}


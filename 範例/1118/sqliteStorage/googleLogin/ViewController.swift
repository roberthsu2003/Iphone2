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
            print("尚未登入");
            return
        }
        print("user uid:\(user.uid)");
        //檢查firestorage 有沒有student1017/UID的節點
        //沒有節點，下載sqlite的檔
        //建立student1017/UID的節點
        //上傳sqlite檔案至student1017/UID的節點內
        
        //有節點，就下載節點sqlite檔
    }
    
    @IBAction func userPressLoggingEvent(_ sender:UIButton){
        print("LoggingEvent");
    }


}


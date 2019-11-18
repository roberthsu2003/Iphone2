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
    }
    
    @IBAction func userPressLoggingEvent(_ sender:UIButton){
        print("LoggingEvent");
    }


}


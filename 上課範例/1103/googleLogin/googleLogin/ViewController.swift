//
//  ViewController.swift
//  googleLogin
//
//  Created by 徐國堂 on 2019/10/27.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser == nil {
                   //沒有登入
                   print("沒有登入，顯示登入畫面");
                   performSegue(withIdentifier: "goLogin", sender: nil)
               }else{
                   //已經登入
                   print("\(Auth.auth().currentUser!.uid)")
               }
    }


}


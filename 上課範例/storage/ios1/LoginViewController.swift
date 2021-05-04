//
//  LoginViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/5/4.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
            guard let _ = result, error == nil else{
                print("login 錯誤")
                return
            }
            print("login成功")
            self.dismiss(animated: true, completion: nil)
        }
    }
    

  

}

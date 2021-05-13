//
//  LoginViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/5/13.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    var math = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error? )in
            guard let _ = result, error == nil else { return }
            
            print("login成功")
            self.math = 100
            self.performSegue(withIdentifier: "back", sender: nil)
        }
 
        
        
    }
   
}

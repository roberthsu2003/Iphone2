//
//  LoginViewController.swift
//  googleLogin
//
//  Created by 徐國堂 on 2019/10/30.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    

    

}

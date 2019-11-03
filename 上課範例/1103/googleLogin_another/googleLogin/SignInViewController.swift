//
//  SignInViewController.swift
//  googleLogin
//
//  Created by 徐國堂 on 2019/11/3.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    

    @IBAction func userPressSign(_ sender:UIButton){
        //GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }

}

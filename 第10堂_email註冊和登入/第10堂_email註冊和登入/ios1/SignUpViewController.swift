//
//  SignUpViewController.swift
//  ios1
//
//  Created by teacher on 2018/3/25.
//  Copyright © 2018年 teacher. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UITableViewController {
    @IBOutlet var emailField:UITextField!;
    @IBOutlet var passwordField:UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender:UIButton){
        let email = emailField.text!;
        let password = passwordField.text!;
        Auth.auth().createUser(withEmail: email, password: password) { (result:AuthDataResult?, error:Error?) in
            guard let result = result, error == nil else{
                //註冊失敗
                let alertController = UIAlertController(title: "註冊失敗", message: error!.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction.init(title: "OK", style: .default, handler: {
                    _ in
                    self.emailField.text = "";
                    self.passwordField.text = "";
                })
                
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                return;
            }
            print("註冊成功:\(result.user.email!)");
            self.dismiss(animated: true, completion: nil);
        }
    }

   
}

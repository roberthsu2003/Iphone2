//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/29.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil{
            print("nil")
            performSegue(withIdentifier: "goLoading", sender: nil)
        }else{
            print("login完成")
            performSegue(withIdentifier: "goLoading", sender: nil)
        }
    }


}


//
//  FirstViewController.swift
//  傳回資料
//
//  Created by 徐國堂 on 2021/4/1.
//

import UIKit

class FirstViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var passwordField:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func userOk(_ sender:UIBarButtonItem){
        navigationController?.popToRootViewController(animated: true)
    }
    
    deinit{
        print("FirstViewController記憶體被釋放了")
    }

}

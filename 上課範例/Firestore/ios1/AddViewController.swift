//
//  AddViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/29.
//

import UIKit

class AddViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var urlField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addDone(_ sender:UIBarButtonItem){
        switch (nameField.text!, urlField.text!){
        case ("",""):
            //UIAlertViewController
            print("2欄都沒有值")
            return;
        
        case ("",_):
            print("第1欄不可以是空的")
            return
        
        case (_,""):
            print("第2欄不可以是空的")
            return
        case let(name, url):
            print(name)
            print(url)
        }
    }

    
}

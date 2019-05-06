//
//  AddViewController.swift
//  firestore
//
//  Created by Robert on 2019/5/6.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!;
    @IBOutlet var urlField:UITextField!;
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func addUser(_ sender:UIBarButtonItem){
        switch(nameField.text!, urlField.text!){
            case ("",""):
                print("不能是空的");
                return;
            case (_,""):
                print("url不能是空的");
                return
            case ("",_):
                print("name不能是空的");
                return
            case let(name,url):
                print("\(name),\(url)")
        }
        
    }
}

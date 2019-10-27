//
//  AddViewController.swift
//  firestore_project1
//
//  Created by 徐國堂 on 2019/10/27.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var urlField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func userAdd(_ sender:UIBarButtonItem){
        switch(nameField.text!, urlField.text!){
            case ("",""):
                print("不能是空的欄位");
            
            case(_,""):
                print("url欄位是空的");
            
            case("",_):
                print("name欄位不能是空的");
          case let(name,url):
                saveToFireStore(userData: [
                    "name":name,
                    "url":url,
                    "time":Date().timeIntervalSince1970
                ])
        }
    }
    
    func saveToFireStore(userData user:[String:Any]){
        print(user)
    }
    
}

//
//  AddViewController.swift
//  firestore
//
//  Created by 徐國堂 on 2019/10/28.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var urlField:UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func userDone(_ sender:UIBarButtonItem){
        switch (nameField.text!,urlField.text!) {
        case ("",""):
            print("2個欄位不可以是空的");
        case (_,""):
            print("url不可以是空的");
        case ("",_):
            print("name不可以是空的");
        case let (name, url):
            saveToFireStore(userData: [
                "name":name,
                "url":url,
                "time":Date().timeIntervalSince1970
            ])
        }
        dismiss(animated: true, completion: nil)
    }
    
    func saveToFireStore(userData users:[String:Any]){
        print(users);
    }

}

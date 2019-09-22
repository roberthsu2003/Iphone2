//
//  AddViewController.swift
//  ios1
//
//  Created by teacher on 2018/6/11.
//  Copyright © 2018年 robert. All rights reserved.
//

import UIKit
import Firebase;

class AddViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!;
    @IBOutlet var urlField:UITextField!;
    let fireStore = Firestore.firestore();
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func userAdd(_ sender:UIBarButtonItem){
        switch (nameField.text!,urlField.text!){
        case ("",""):
            print("不能是空的");
            return;
        
        case (_,""):
            print("不能是空的");
            return;
            
        case ("",_):
            print("不能是空的");
            return;
        case let(name,url):
            saveToFireStore(userData: [
                "name":name,
                "url":url,
                "time":Date().timeIntervalSince1970
                ]);
        }
    }
    
    func saveToFireStore(userData users:[String:Any]){
        let _ = fireStore.collection("presidents").addDocument(data: users) { (error:Error?) in
            if let error = error {
                print("error:\(error)");
            }else{
                print("新增成功");
                let _ = self.navigationController?.popViewController(animated: true);
            }
        }
    }
}

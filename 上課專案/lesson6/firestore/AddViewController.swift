//
//  AddViewController.swift
//  firestore
//
//  Created by Robert on 2019/5/6.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!;
    @IBOutlet var urlField:UITextField!;
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func addUser(_ sender:UIBarButtonItem){
        var message =  "";
        switch(nameField.text!, urlField.text!){
            case ("",""):
                
                message = "不能是空的"
            case (_,""):
              
                message = "url不能是空的"
            
            case ("",_):
                
                message = "name不能是空的"
            
            case let(name,url):
                saveToFireStore(userData: [
                    "name":name,
                    "url":url,
                    "time":Date().timeIntervalSince1970
                    ])
                return;
        }
        
        if message != ""{
            let alertController = UIAlertController(title: "警告", message: message, preferredStyle: .alert);
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction);
            
            //presend
            present(alertController, animated: true, completion: nil)
            
        }
        
       
        
        
        
    }
    func saveToFireStore(userData users:[String:Any]){
        let _ = Firestore.firestore().collection("presidents").addDocument(data: users) { (error:Error?) in
            if let error = error{
                print("error:\(error)");
            }else{
                print("新增成功")
                let _ = self.navigationController!.popViewController(animated: true)
            }
        }
    }
}

//
//  EditViewController.swift
//  firestore_project1
//
//  Created by 徐國堂 on 2019/10/27.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var urlField:UITextField!
    var president:QueryDocumentSnapshot!
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presidentDic = president.data()
        print("presidentDic:\(presidentDic)")
        
        nameField.text = presidentDic["name"] as? String;
        urlField.text = presidentDic["url"] as? String;
    }
    
    
    @IBAction func userPressUpdate(_ sender:UIBarButtonItem){
        print("press update")
        let documentID = president.documentID;
        firestore.collection("presidents").document(documentID).updateData( [
                       "name":nameField.text!,
                       "url":urlField.text!,
                       "time":Date().timeIntervalSince1970
        ]) { (error:Error?) in
            guard error == nil else{
                print("更新失敗");
                return
            }
            
            print("更新成功");
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

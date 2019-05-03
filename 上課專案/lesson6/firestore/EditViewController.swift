//
//  EditViewController.swift
//  firestore
//
//  Created by Robert on 2019/5/3.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UITableViewController {
    var queryDocumentSnapshot:QueryDocumentSnapshot!;
    @IBOutlet var nameField:UITextField!;
    @IBOutlet var urlField:UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

       print(queryDocumentSnapshot.documentID)
       let presidentDic = queryDocumentSnapshot.data()
        nameField.text = presidentDic["name"] as? String;
        urlField.text = presidentDic["url"] as? String;
    }

   

}

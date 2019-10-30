//
//  EditViewController.swift
//  firestore
//
//  Created by 徐國堂 on 2019/10/28.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UITableViewController {
    var documentSnapshot:QueryDocumentSnapshot!;
    
    @IBOutlet var nameField:UITextField!
    @IBOutlet var urlField:UITextField!
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = documentSnapshot.data()
        nameField.text = data["name"] as? String
        urlField.text = data["url"] as? String
    }
    

    @IBAction func userDone(_ sender:UIBarButtonItem){
        let documentId = documentSnapshot.documentID
        firestore.collection("presidents").document(documentId).updateData([
            "name":nameField.text!,
            "url":urlField.text!,
            "time":Date().timeIntervalSince1970
        ])        
        dismiss(animated: true, completion: nil)
    }

}

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
    var documentId:String!;
    
    @IBOutlet var nameField:UITextField!;
    @IBOutlet var urlField:UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
       let presidentDic = queryDocumentSnapshot.data()
        nameField.text = presidentDic["name"] as? String;
        urlField.text = presidentDic["url"] as? String;
        documentId = queryDocumentSnapshot.documentID
    }

    @IBAction func userPressDone(_ sender:UIBarButtonItem){
        let collections = Firestore.firestore().collection("presidents");
        collections.document(documentId).updateData([
            "name" : nameField.text!,
            "url"  : urlField.text!
            
        ])
        
        navigationController!.popViewController(animated: true)
    }

}

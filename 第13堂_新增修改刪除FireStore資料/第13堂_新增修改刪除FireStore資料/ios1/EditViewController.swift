//
//  EditViewController.swift
//  ios1
//
//  Created by teacher on 2018/6/11.
//  Copyright © 2018年 robert. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UITableViewController {
    var queryDocumentSnapshot:QueryDocumentSnapshot!;
    @IBOutlet var nameField:UITextField!;
    @IBOutlet var urlField:UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("documentId:\(queryDocumentSnapshot.documentID)");
        let presidents = queryDocumentSnapshot.data();
        nameField.text = presidents["name"] as? String;
        urlField.text = presidents["url"] as? String;
        
    }

    
    
    @IBAction func userStopEditing(_ sender:UITextField){
        print("stop Editting");
    }
    
    @IBAction func userStopEditingAndExit(_ sender:UITextField){
        print("stop Eidtting and Exit");
    }
    
    @IBAction func userPressDone(_ sender:UIBarButtonItem){
        print("press Done");
        Firestore.firestore().collection("presidents").document(queryDocumentSnapshot.documentID).updateData([
            "name":nameField.text!,
            "url":urlField.text!
            ]);
        
        navigationController!.popViewController(animated: true);
    }

    

}

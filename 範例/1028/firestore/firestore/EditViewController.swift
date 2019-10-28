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
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = documentSnapshot.data()
        print(data);
    }
    

    @IBAction func userDone(_ sender:UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }

}

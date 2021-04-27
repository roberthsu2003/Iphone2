//
//  EditViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/22.
//

import UIKit
import Firebase

class EditViewController: UITableViewController {
    var queryDocumentSnapshot:QueryDocumentSnapshot!
    var data:[String:Any]!
    @IBOutlet var nameField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = queryDocumentSnapshot.data()
        nameField.text = data["name"] as? String
       
    }
    
    @IBAction func userPressDone(_ sender:UIBarButtonItem){
        print("更新雲端資料，回ViewController，重新載入新的資料")
        let documentId = queryDocumentSnapshot.documentID
        data["name"] = nameField.text
        Firestore.firestore().collection("presidents").document(documentId).updateData(data)
        navigationController!.popViewController(animated: true)
    }

    
}

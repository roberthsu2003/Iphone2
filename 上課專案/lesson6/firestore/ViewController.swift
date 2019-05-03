//
//  ViewController.swift
//  firestore
//
//  Created by Robert on 2019/5/1.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    lazy var firestore = Firestore.firestore()
    lazy var presidentsCols = firestore.collection("presidents")
    let presidents:[[String:String]] = {
        let path = Bundle.main.path(forResource: "PresidentList", ofType: "plist")!
        if let rootDictionary = NSDictionary(contentsOfFile: path) as? [String:Any]{
            let presidents = rootDictionary["presidents"] as! [[String:String]]
            return presidents
        }
        return [[:]]
    }()
    
    var queryDocuments:[QueryDocumentSnapshot] = []; //提供tableView資料
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let presidentsCols = firestore.collection("presidents")
        let _ = presidentsCols.addSnapshotListener { (presidentsSnapshot:QuerySnapshot?, error:Error?) in
            if error != nil {
                print("error:\(error!.localizedDescription)");
                return;
            }
            
            if presidentsSnapshot!.isEmpty{
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "上傳資料", style: .plain, target: self, action: #selector(self.importData(_:)))
            }else{
                print("集合已經有資料");
                self.queryDocuments = presidentsSnapshot!.documents
                print(self.queryDocuments);
                self.tableView.reloadData();
            }
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEdit"{
            let indexPath = sender as! IndexPath
            let queryDocumentSnapshot = queryDocuments[indexPath.row]
            let editViewController = segue.destination as! EditViewController
            editViewController.queryDocumentSnapshot = queryDocumentSnapshot
            
        }
    }

    @objc func importData(_ sender:UIBarButtonItem){
        let batch = firestore.batch();
        for president in presidents{
            let documentRef = firestore.collection("presidents").document();
            var newPresident:[String:Any] = president
            newPresident["time"] = Date().timeIntervalSince1970
            batch.setData(newPresident, forDocument: documentRef)
        }
        batch.commit { (error:Error?) in
            if error != nil {
                print("batch出錯了");
                return;
            }
            
            self.navigationItem.rightBarButtonItem = nil;
        }
        
    }
}

extension ViewController{
    //UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return queryDocuments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let queryDocumentSnapshot = queryDocuments[indexPath.row]
        let presidentsDict = queryDocumentSnapshot.data();
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.accessoryType = .detailButton;
        cell.textLabel!.text = presidentsDict["name"] as? String;
        cell.detailTextLabel!.text = presidentsDict["url"] as? String;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let queryDocumentSnapshot = queryDocuments[indexPath.row];
            let documentId = queryDocumentSnapshot.documentID;
            presidentsCols.document(documentId).delete { (error:Error?) in
                
                if error != nil {
                    print("刪除錯誤");
                }else{
                    print("刪除成功");
                }
            }
        }
    }
}

extension ViewController{
    //UITableViewDelegate
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        performSegue(withIdentifier: "goEdit", sender: indexPath)
    }
}


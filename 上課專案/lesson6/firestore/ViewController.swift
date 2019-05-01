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
    let firestore = Firestore.firestore()
    let presidents:[[String:String]] = {
        let path = Bundle.main.path(forResource: "PresidentList", ofType: "plist")!
        if let rootDictionary = NSDictionary(contentsOfFile: path) as? [String:Any]{
            let presidents = rootDictionary["presidents"] as! [[String:String]]
            return presidents
        }
        return [[:]]
    }()
    
    var queryDocuments:[QueryDocumentSnapshot] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let presidentsCols = firestore.collection("presidents")
        presidentsCols.addSnapshotListener { (presidentsSnapshot:QuerySnapshot?, error:Error?) in
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
        let dataDict = queryDocumentSnapshot.data();
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel!.text = dataDict["name"] as? String;
        cell.detailTextLabel!.text = dataDict["url"] as? String;
        return cell;
    }
}


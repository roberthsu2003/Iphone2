//
//  ViewController.swift
//  ios1
//
//  Created by teacher on 2018/6/6.
//  Copyright © 2018年 robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    lazy var firestore = Firestore.firestore();
    lazy var presidents:[[String:String]] = {
        let path = Bundle.main.path(forResource: "PresidentList", ofType: "plist");
        if let rootDictionary = NSDictionary(contentsOfFile: path!) as? [String:Any]{
            let presidents = rootDictionary["presidents"];
            return presidents as! [[String:String]];
        }
        return [[:]]
        
    }();
    
    var queryDocuments:[QueryDocumentSnapshot] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //監聽
        firestore.collection("presidents").order(by: "time", descending: true).addSnapshotListener { (presidentsSnapshot:QuerySnapshot?, error:Error?) in
            if error != nil {
                print("error\((error?.localizedDescription)!)");
                return
            }
            
            if presidentsSnapshot!.isEmpty{
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "匯入資料", style: .plain, target: self, action: #selector(self.importData(_:)));
            }else{
                self.queryDocuments = (presidentsSnapshot?.documents)!;
                print(self.queryDocuments);
                self.tableView.reloadData();
            }
        }
        /*
        firestore.collection("presidents").getDocuments { (presidentsSnapshot:QuerySnapshot?, error:Error?) in
            
        }
 */
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEdit"{
            let selectedIndex = sender as! IndexPath
            let editViewController = segue.destination as! EditViewController;
            editViewController.queryDocumentSnapshot = queryDocuments[selectedIndex.row];
        }
    }

    @objc func importData(_ sender:UIBarButtonItem){
        print("匯入資料");
        let batch = firestore.batch();
        for president in presidents{
            let documentRef = firestore.collection("presidents").document();
            var newPresident:[String:Any] = president;
            newPresident["time"] = Date().timeIntervalSince1970
            batch.setData(newPresident, forDocument: documentRef);
        }
        batch.commit { (error:Error?) in
            if error != nil {
                print("batch出錯了");
            }
        }
        
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController{
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return queryDocuments.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath);
        cell.accessoryType = .detailButton;
        let queryDocumentSnapshot = queryDocuments[indexPath.row];
        let dataDict = queryDocumentSnapshot.data();
        cell.textLabel?.text = dataDict["name"] as? String;
        cell.detailTextLabel?.text = String(dataDict["time"] as! Double);
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        let queryDocumentSnapshot = queryDocuments[indexPath.row];
        let documentId = queryDocumentSnapshot.documentID;
        firestore.collection("presidents").document(documentId).delete { (error:Error?) in
            if let error = error {
                print("刪除失敗\(error)");
            }
            
            
        }
    }
}

extension ViewController{
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        print("detailButton/row:\(indexPath.row)");
        performSegue(withIdentifier: "goEdit", sender: indexPath);
    }
}


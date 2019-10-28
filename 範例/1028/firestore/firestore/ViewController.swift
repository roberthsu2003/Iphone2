//
//  ViewController.swift
//  firestore
//
//  Created by 徐國堂 on 2019/10/23.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    var presidents:[[String:String]] = {
        guard let path = Bundle.main.path(forResource: "PresidentList", ofType: "plist") else{
            print("解析失敗");
            return [[String:String]]();
        }
        
        let presidentsRoot = NSDictionary(contentsOfFile: path) ?? NSDictionary();
        
        return presidentsRoot["presidents"] as! [[String:String]]
    }()
    
    var firestore = Firestore.firestore()
    var handler:ListenerRegistration!;
    var queryDocuments = [QueryDocumentSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //getDocuments只會執行一次
        firestore.collection("presidents").getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
            guard snapshot != nil, error == nil else{
                print("get presidents 錯誤");
                return;
            }
            
            if snapshot!.isEmpty{
                //匯入資料
                print("匯入資料");
            }else{
                //資料已經匯入
                print("資料已經匯入");
            }
        
        }
 */
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //最少會執行一次，資料改變時，都會自動執行
        handler =  firestore.collection("presidents").order(by: "time", descending: true).addSnapshotListener { (snapshot:QuerySnapshot?, error:Error?) in
            guard snapshot != nil, error == nil else{
                print("get presidents 錯誤");
                return;
            }
            
            if snapshot!.isEmpty{
                //匯入資料
                //print("匯入資料");
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "匯入資料", style: .plain, target: self, action: #selector(self.importData(_:)))
            }else{
                //資料已經匯入
                print("資料已經匯入");
                 self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPresident(_:)))
                self.queryDocuments = snapshot!.documents
                self.tableView.reloadData();
            }
        
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        handler.remove();
    }
    
    @objc func importData(_ sender:UIBarButtonItem){
        print("匯入資料");
        let batch = firestore.batch();
        for president in presidents{
            let documentsRef = firestore.collection("presidents").document()
            var newPresident:[String:Any] = president
            newPresident["time"] = Date().timeIntervalSince1970
            
            batch.setData(newPresident, forDocument: documentsRef)
        }
        
        batch.commit { (error:Error?) in
            guard error == nil else{
                print("commit錯誤:\(error!.localizedDescription)");
                return;
            }
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPresident(_:)))
            //getDocuments只會執行一次
            self.firestore.collection("presidents").order(by: "time", descending: true).getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
                guard snapshot != nil, error == nil else{
                    print("get presidents 錯誤");
                    return;
                }
                 self.queryDocuments = snapshot!.documents
                 self.tableView.reloadData();
                }
            
            }
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goWebView" {
            let path = sender as? String ?? "";
            let showViewController = segue.destination as! ShowViewController
            showViewController.webPath = path;
        }
    }
    
    @objc func addPresident(_ sender:UIBarButtonItem){
        performSegue(withIdentifier: "goAdd", sender: nil)
    }
    

}

extension ViewController{
    //UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return queryDocuments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let document = queryDocuments[indexPath.row]
        let president = document.data()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.text = president["name"] as? String
        //轉換timestamp為date字串格式
        let unixtimeInterval = president["time"] as? Double ?? 0.0
        let date = Date(timeIntervalSince1970: unixtimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+8") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        
        cell.detailTextLabel?.text = strDate
        return cell;
    }
}


extension ViewController{
    //UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let document = queryDocuments[indexPath.row]
        let president = document.data()
        let path = president["url"] as? String ?? ""
        performSegue(withIdentifier: "goWebView", sender: path)
    }
}


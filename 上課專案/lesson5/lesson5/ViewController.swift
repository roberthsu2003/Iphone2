//
//  ViewController.swift
//  lesson5
//
//  Created by Robert on 2019/4/24.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var tableView:UITableView!;
    
    let presidentsRef = Database.database().reference(withPath: "presidents")
    var presidents = [[String:String]]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Auth.auth().currentUser!.uid
        presidentsRef.observe(.value){
            (snapshot:DataSnapshot) in
            self.presidents = snapshot.value as! [[String:String]]
            print("下載完畢")
            print(self.presidents);
            //我的資料下載完畢,請tableView重新整理資料
            self.tableView.reloadData();
        }
        
        print("尚未下載完畢")
        print(self.presidents);
        
        //tableView.dataSource = self;
        //tableView.delegate = self;
    }


}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (presidents.count == 0) ? 1 : presidents.count ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if presidents.count == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
             cell.textLabel!.text = "資料正在下載中";
            return cell;
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MYCELL", for: indexPath) as! MyCell
            let president = presidents[indexPath.row]
            cell.nameLabel.text = president["name"]
            cell.urlLabel.text = president["url"];
            return cell;
        }
        
        
        
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("您現在點到:\(indexPath.row)")
    }
}


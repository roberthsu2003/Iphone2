//
//  AddViewController.swift
//  firestore_project1
//
//  Created by 徐國堂 on 2019/10/27.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

enum Media {
  case Book(title: String, author: String, year: Int)
  case Movie(title: String, director: String, year: Int)
  case WebSite(urlString: String)
}

class AddViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var urlField:UITextField!
    let firestore = Firestore.firestore();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let m = Media.Movie(title: "Captain America: Civil War", director: "Russo Brothers", year: 2016)
        /*
        switch m {
        case let Media.Movie(title, _, _):
            print(title)
        default:
            print("no")
        }
 */
        if case let Media.Movie(title,  _,  _) = m{
            print(title)
        }
    }
    
    @IBAction func userAdd(_ sender:UIBarButtonItem){
        switch(nameField.text!, urlField.text!){
            case ("",""):
                print("不能是空的欄位");
            
            case(_,""):
                print("url欄位是空的");
            
            case("",_):
                print("name欄位不能是空的");
          case let(name,url):
                saveToFireStore(userData: [
                    "name":name,
                    "url":url,
                    "time":Date().timeIntervalSince1970
                ])
        }
    }
    
    func saveToFireStore(userData user:[String:Any]){
        firestore.collection("presidents").document().setData(user) { (error:Error?) in
            guard error == nil else{
                print(error!.localizedDescription);
                return;
            }
            
            print("資料加入成功");
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

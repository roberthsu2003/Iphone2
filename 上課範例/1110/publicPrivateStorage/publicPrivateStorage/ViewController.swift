//
//  ViewController.swift
//  publicPrivateStorage
//
//  Created by 徐國堂 on 2019/11/10.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userAuthentication();
    }
    
   
    
    func userAuthentication(){
        if Auth.auth().currentUser == nil {
                   //尚未認證
                   Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                       guard result != nil, error == nil else{
                           print("anoonymously失敗");
                           return
                       }
                    
                    self.tableView.reloadData();
                   }
                   
               }else{
                   //已經認證
                   
               }
    }


}


//
//  ViewController.swift
//  ios1
//
//  Created by teacher on 2018/3/18.
//  Copyright © 2018年 teacher. All rights reserved.
//

import UIKit
import Firebase;

class ViewController: UIViewController {
    @IBOutlet var tableView:UITableView!;
    
   
    var authHandler:AuthStateDidChangeListenerHandle!;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        authHandler = Auth.auth().addStateDidChangeListener { (auth:Auth, user:User?) in
            
            if user == nil {
                //移至登入畫面
                print("執行登入畫面");
                self.performSegue(withIdentifier: "goSignin", sender: nil);
            }else{
                //建立logout button
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登出", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.logout(_:)))
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        Auth.auth().removeStateDidChangeListener(authHandler);
    }
    
    
    @objc func logout(_ sender:UIBarButtonItem){
        if (try? Auth.auth().signOut()) == nil{
            print("signOut失敗");
        }
        self.performSegue(withIdentifier: "goSignin", sender: nil);
        
    }


}





//
//  DHTViewController.swift
//  realtimeDataBase
//
//  Created by 徐國堂 on 2019/10/21.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class DHTViewController: UIViewController {
    @IBOutlet var HumidityField:UITextField!
    @IBOutlet var FahrenheitField:UITextField!
    @IBOutlet var FahrenheitIndexField:UITextField!
    @IBOutlet var CelsiusField:UITextField!
    @IBOutlet var CelsiusIndexField:UITextField!
    var handle:AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth:Auth, user:User?) in
            if let user = user {
               //已經登入
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登出", style: .plain, target: self, action: #selector(self.userLogout(_:)))
                print(user.uid);
            }else{
                //尚未登入
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登入", style: .plain, target: self, action: #selector(self.userLogin(_:)))
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    @objc func userLogout(_ sender:UIBarButtonItem){
        guard  (try? Auth.auth().signOut()) != nil else{
            print("登出失敗");
            return
        }
        print("登出成功");
    }
    
    @objc func userLogin(_ sender:UIBarButtonItem){
        Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
            guard error == nil, result != nil else{
                print("暱名登入有錯誤:\(error!.localizedDescription)");
                return
            }
            
            let user = result!.user
            if user.isAnonymous {
                print("暱名登入成功")
            }
            
        }
    }

}

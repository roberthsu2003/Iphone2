//
//  ViewController.swift
//  ios1
//
//  Created by Robert on 2019/3/28.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    var ref:DatabaseReference = Database.database().reference();
    @IBOutlet var actionButton:UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user{
                //登入成功執行區
                self.title = "暱名登入id:" + user.uid;
                print("user=\(user.uid)")
                
                
            }else{
                //沒有登入
                self.actionButton.setTitle("暱名登入", for: .normal)
                self.title = "暱名登入";
            }
        }
        
        

    }
    
    @IBAction func userClickTopButton(_ topButton:UIButton){
        switch topButton.currentTitle!{
        case "暱名登入":
            Auth.auth().signInAnonymously { (authResult:AuthDataResult?,error:Error?) in
                guard let _ = authResult , error == nil else{
                    print("user=暱名登入錯誤");
                    return;
                }
               
               topButton.setTitle("登出", for: .normal)
                
                
            }
        
        case "登出":
            if (try? Auth.auth().signOut()) == nil {
                print("user=signout失敗")
            }else{
                print("user=signout成功")
            }
            
        default:break;
        }
    }
    
    
    @IBAction func userClickBottomBtn(_ sender:UIButton){
        let relayRef = ref.child("Relay")
        relayRef.setValue(["D1":false]) { (error:Error?, DatabaseRef:DatabaseReference) in
            var message:String = ""
            if let error = error{
                print("user=\(error.localizedDescription)");
                message = error.localizedDescription;
                
            }else{
                message = "資料讀取正常";
            }
            
            let alertController = UIAlertController(title: "讀取狀態", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "知道", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil);
            
        }
    }
    
}


//
//  ViewController.swift
//  lesson4
//
//  Created by Robert on 2019/4/22.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var actionButton:UIButton!;
    var handle:AuthStateDidChangeListenerHandle!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("storyboard的view已經ready,可以使用了");
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view將出現了");
        handle = Auth.auth().addStateDidChangeListener { (auth:Auth, user:User?) in
            if let myuser = user{
                self.title = myuser.uid
                print("做用者的uid:\(myuser.uid)");
                self.actionButton.setTitle("登出", for: UIControl.State.normal)
            }else{
                self.actionButton.setTitle("暱名登入", for: UIControl.State.normal)
                self.title = "暱名登入"
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view已經出現");
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view已經離開")
    }
    
    @IBAction func userClickToButton(_ sender:UIButton) {
        switch sender.currentTitle!{
            case "暱名登入":
                Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                    guard let _ = result, error == nil else{
                        print("暱名登入錯誤");
                        return
                    }
                   print("暱名登入成功");
            }
            
            case "登出":
               
                if (try? Auth.auth().signOut()) == nil {
                    print("登出錯誤")
                    return;
                }else{
                   print("登出成功")
                }
 
            //try! Auth.auth().signOut()
            
            
            default:break;
        }
        
    }

}


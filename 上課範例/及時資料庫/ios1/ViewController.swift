//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/8.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var relayRef:DatabaseReference!
    override func awakeFromNib() {
        super.awakeFromNib()
        //暱名登入
        Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
            guard let result = result, error == nil else{
                return
            }
            let user = result.user
           
            if user.isAnonymous{
                print(user.uid)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        relayRef = Database.database().reference(withPath: "relay/d1")
        relayRef.observe(.value) { (snapshot:DataSnapshot) in
            print("資料改變了")
        }
    }


}


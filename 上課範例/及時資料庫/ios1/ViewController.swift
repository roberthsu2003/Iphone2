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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        relayRef = Database.database().reference(withPath: "relay/d1")
        relayRef.observe(.value) { (snapshot:DataSnapshot) in
            print("資料改變了")
        }
    }


}


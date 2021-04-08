//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/7.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var relayRef:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        relayRef = Database.database().reference(withPath: "Relay/D1")
        relayRef.observe(.value) { (snapshot:DataSnapshot) in
            let d1State = snapshot.value as! Bool
            print(d1State)
        }
    }


}


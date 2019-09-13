//
//  ViewController.swift
//  RealTimeDataBase
//
//  Created by Robert on 2019/9/8.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var relayRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        relayRef = Database.database().reference();
        relayRef.child("Relay/D1").observeSingleEvent(of: .value, with: {
            (snapshot:DataSnapshot) -> Void in
            let d1State = snapshot.value as? Bool ?? false;
            print(d1State)
        })
        
    }


}


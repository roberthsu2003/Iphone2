//
//  ViewController.swift
//  ios1
//
//  Created by Robert on 2019/4/15.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var ref: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        ref = Database.database().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}


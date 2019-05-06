//
//  ViewController.swift
//  cities
//
//  Created by Robert on 2019/5/6.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    let storage = Storage.storage()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let imagesRef = storage.reference(withPath: "n135/images/Akihabara.jpg");
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}


//
//  ViewController.swift
//  lesson5
//
//  Created by Robert on 2019/4/24.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Auth.auth().currentUser!.uid
    }


}


//
//  ViewController.swift
//  FirstProject
//
//  Created by Robert on 2019/10/7.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var state = DataSource.main.state
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("state的數量:\(state.count)")
    }


}


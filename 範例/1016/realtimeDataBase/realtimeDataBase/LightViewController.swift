//
//  LightViewController.swift
//  realtimeDataBase
//
//  Created by 徐國堂 on 2019/10/16.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class LightViewController: UIViewController {
    @IBOutlet var lightBtn:UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func userChangeLight(_ sender:UIButton){
        print("user change");
    }

}

//
//  DHTViewController.swift
//  realtimeDataBase
//
//  Created by 徐國堂 on 2019/10/21.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class DHTViewController: UIViewController {
    @IBOutlet var HumidityField:UITextField!
    @IBOutlet var FahrenheitField:UITextField!
    @IBOutlet var FahrenheitIndexField:UITextField!
    @IBOutlet var CelsiusField:UITextField!
    @IBOutlet var CelsiusIndexField:UITextField!
    var handle:AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth:Auth, user:User?) in
            print("authListener");
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle)
    }

}

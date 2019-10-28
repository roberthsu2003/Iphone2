//
//  AddViewController.swift
//  firestore
//
//  Created by 徐國堂 on 2019/10/28.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var urlField:UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func userDone(_ sender:UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }

}

//
//  AddViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/29.
//

import UIKit

class AddViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var urlField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addDone(_ sender:UIBarButtonItem){
        print("addDone")
    }

    
}

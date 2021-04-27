//
//  EditViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/22.
//

import UIKit

class EditViewController: UITableViewController {
    var name:String!
    @IBOutlet var nameField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = name
       
    }

    
}

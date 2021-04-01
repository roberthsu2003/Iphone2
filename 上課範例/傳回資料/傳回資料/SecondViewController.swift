//
//  SecondViewController.swift
//  傳回資料
//
//  Created by 徐國堂 on 2021/4/1.
//

import UIKit

class SecondViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var passwordField:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func userOk(_ sender:UIBarButtonItem){
        
        let name = nameField.text!
        let password = passwordField.text!
        
        navigationController?.popToRootViewController(animated: true)
    }

}

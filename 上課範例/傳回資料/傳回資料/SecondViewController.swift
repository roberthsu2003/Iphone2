//
//  SecondViewController.swift
//  傳回資料
//
//  Created by 徐國堂 on 2021/4/1.
//

import UIKit

typealias Transform = (String,String) -> Void

class SecondViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var passwordField:UITextField!
    var passBack:(Transform)!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func userOk(_ sender:UIBarButtonItem){
        
        let name = nameField.text!
        let password = passwordField.text!
        passBack(name,password)
        navigationController?.popToRootViewController(animated: true)
    }

}

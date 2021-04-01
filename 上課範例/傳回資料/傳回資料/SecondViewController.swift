//
//  SecondViewController.swift
//  傳回資料
//
//  Created by 徐國堂 on 2021/4/1.
//

import UIKit

typealias Transform = (String,String,Error?) -> Void

class SecondViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var passwordField:UITextField!
    var passBack:(Transform)!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func connectToSecond(c:@escaping Transform){
        passBack = c
    }

    @IBAction func userOk(_ sender:UIBarButtonItem){
        
        let name = nameField.text!
        let password = passwordField.text!
        passBack(name,password,nil)
        navigationController?.popToRootViewController(animated: true)
    }

}

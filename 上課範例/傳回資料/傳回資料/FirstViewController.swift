//
//  FirstViewController.swift
//  傳回資料
//
//  Created by 徐國堂 on 2021/4/1.
//

import UIKit
protocol FirstViewControlerDelegate:NSObject {
    func dataPassBack(userName name:String,userPassword password:String)
}
class FirstViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var passwordField:UITextField!
    weak var delegate:FirstViewControlerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func userOk(_ sender:UIBarButtonItem){
        navigationController?.popToRootViewController(animated: true)
        let name = nameField.text!
        let password = passwordField.text!
        delegate.dataPassBack(userName: name, userPassword: password)
    }
    
    deinit{
        print("FirstViewController記憶體被釋放了")
    }

}

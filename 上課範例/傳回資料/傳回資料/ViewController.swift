//
//  ViewController.swift
//  傳回資料
//
//  Created by 徐國堂 on 2021/4/1.
//

import UIKit

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FIRST"{
            let firstViewController = segue.destination as! FirstViewController
            firstViewController.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController:FirstViewControlerDelegate{
    func dataPassBack(userName name:String,userPassword password:String){
        print("使用者名稱是:\(name)")
        print("使用者密碼是:\(password)")
    }
}


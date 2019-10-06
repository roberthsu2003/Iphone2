//
//  ViewController.swift
//  fireStore
//
//  Created by Robert on 2019/10/6.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "PresidentList", ofType: "plist"){
            if let rootDictionary = NSDictionary(contentsOfFile: path) as? [String:Any]{
                let presidents = rootDictionary["presidents"] as! [[String:String]]
                print(presidents);
                
            }
        }
    }

    @IBAction func importData(_ sender:UIBarButtonItem){
        print("匯入資料至Firebase");
    }
}


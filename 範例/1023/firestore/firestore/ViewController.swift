//
//  ViewController.swift
//  firestore
//
//  Created by 徐國堂 on 2019/10/23.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var presidents:[[String:String]] = {
        guard let path = Bundle.main.path(forResource: "PresidentList", ofType: "plist") else{
            print("解析失敗");
            return [[String:String]]();
        }
        
        let presidentsRoot = NSDictionary(contentsOfFile: path) ?? NSDictionary();
        
        return presidentsRoot["presidents"] as! [[String:String]]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(presidents);
    }


}


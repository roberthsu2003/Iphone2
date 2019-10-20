//
//  ViewController.swift
//  firestore_project1
//
//  Created by 徐國堂 on 2019/10/20.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    //default value當有多行時,請使用closure執行
    //使用closure的執行，必需明確宣告資料類型
    //在closure內要傳出資料
    
    lazy var presidents:[[String:String]] = {
        let path = Bundle.main.path(forResource: "PresidentList", ofType: "plist")
        guard let rootDictionary = NSDictionary(contentsOfFile: path!) as? [String:Any] else{
            print("解析資料有問題")
            return [[String:String]]()
        }
        
        let presidents = rootDictionary["presidents"] as! [[String:String]]
        return presidents;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("count:\(presidents)")
    }


}


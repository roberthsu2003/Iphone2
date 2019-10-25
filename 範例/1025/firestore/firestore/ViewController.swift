//
//  ViewController.swift
//  firestore
//
//  Created by 徐國堂 on 2019/10/23.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var presidents:[[String:String]] = {
        guard let path = Bundle.main.path(forResource: "PresidentList", ofType: "plist") else{
            print("解析失敗");
            return [[String:String]]();
        }
        
        let presidentsRoot = NSDictionary(contentsOfFile: path) ?? NSDictionary();
        
        return presidentsRoot["presidents"] as! [[String:String]]
    }()
    
    var firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firestore.collection("presidents").getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
            guard snapshot != nil, error == nil else{
                print("get presidents 錯誤");
                return;
            }
            
            if snapshot!.isEmpty{
                //匯入資料
                print("匯入資料");
            }else{
                //資料已經匯入
                print("資料已經匯入");
            }
        }
    }


}


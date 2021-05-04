//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/29.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    let firestore = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        //登入動作
        if Auth.auth().currentUser == nil{
            print("nil")
            performSegue(withIdentifier: "goLoading", sender: nil)
        }else{
            print("login完成")
            //performSegue(withIdentifier: "goLoading", sender: nil)
        }
        
        //檢查Firestore有沒有資料
        firestore.collection("cities").getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
            guard let snapshot = snapshot, error == nil else{
                print("取得documents失敗")
                return
            }
            
            if snapshot.isEmpty{
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "匯入資料", style: .plain, target: self, action: #selector(self.uploadData(_:)))
            }else{
                print("已經有資料")
            }
        }
    }

    @objc func uploadData(_ sender:UIBarButtonItem){
        print("上傳資料")
    }
}


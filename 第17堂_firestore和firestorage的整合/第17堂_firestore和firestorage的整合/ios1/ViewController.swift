//
//  ViewController.swift
//  ios1
//
//  Created by Robert on 2019/4/2.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    let storage = Storage.storage();
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib();
        let imagesRef = storage.reference(withPath: "n135/images/kihabara.jpg")
        imagesRef.getData(maxSize: 1 * 1024 * 1024) { (data:Data?, error:Error?) in
            if let error = error, data == nil{
                print(error.localizedDescription)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "上傳圖片資料", style: .plain, target: self, action: #selector(self.upLoadCities))
            }else{
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "顯示資料", style: .plain, target: self, action: #selector(self.displayCities))
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @objc func displayCities(){
        
    }
    
    @objc func upLoadCities(){
        
    }
}


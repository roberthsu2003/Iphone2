//
//  ViewController.swift
//  cities
//
//  Created by Robert on 2019/5/6.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    let storage = Storage.storage()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let imagesRef = storage.reference(withPath: "n135/images/Akihabara.jpg");
        let _ = imagesRef.getData(maxSize: (1 * 1024 * 1024)) { (data:Data?, error:Error?) in
            if let error = error, data == nil{
                print(error);
                print(data ?? "沒有資料")
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "上傳圖片資料", style: .plain, target: self, action: #selector(self.upLoadCities))
            }else{
                print("有圖片");
            }
        }
    }
    
    @objc func upLoadCities(){
        let cityPath = Bundle.main.path(forResource: "citylist", ofType: "plist")!
        let citys = NSArray(contentsOfFile: cityPath) as! [[String:String]]
        for city in citys{
            print(city)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}


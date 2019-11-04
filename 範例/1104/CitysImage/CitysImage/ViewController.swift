//
//  ViewController.swift
//  CitysImage
//
//  Created by 徐國堂 on 2019/11/4.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        DataSource.dataSource.viewController = self;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func createUpLoadData() -> Void{
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "上傳資料", style: .plain, target: self, action: #selector(uploadData(_:)))
    }
    
    @objc func uploadData(_ sender:UIBarButtonItem){
        print("uploadData");
    }

}


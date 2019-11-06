//
//  ViewController.swift
//  CitysImage
//
//  Created by 徐國堂 on 2019/11/4.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    var citys:[QueryDocumentSnapshot]!;
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         DataSource.dataSource.createUpLoadButton = {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "上傳資料", style: .plain, target: self, action: #selector(self.uploadData(_:)))
          }
        DataSource.dataSource.createImageUPLoadButton = {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "上傳圖片", style: .plain, target: self, action: #selector(self.uploadImage(_:)))
            
        }
        
        citys = DataSource.dataSource.getCityData
    }
    
   
    @objc func uploadData(_ sender:UIBarButtonItem){
        DataSource.dataSource.uploadDataToFireStore()
    }
    
    @objc func uploadImage(_ sender:UIBarButtonItem){
        DataSource.dataSource.uploadImageToFireStore()
        navigationItem.rightBarButtonItem = nil;
    }

}


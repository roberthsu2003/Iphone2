//
//  ViewController.swift
//  cities
//
//  Created by Robert on 2019/5/6.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    let storage = Storage.storage()
    let firestore = Firestore.firestore();
    
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
        let cityCollection = firestore.collection("cities")
        let storageImageRef = storage.reference(withPath: "n135/images");
        for city in citys{
            cityCollection.addDocument(data: city) { (error:Error?) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
           let cityImgageName = city["Image"]!
           let cityImage = UIImage(named: cityImgageName)!
           let cityImageData = cityImage.jpegData(compressionQuality: 1.0)
           let metaData = StorageMetadata();
           metaData.contentType = "image/jpg";
           let imageNameRef = storageImageRef.child(cityImgageName)
           imageNameRef.putData(cityImageData!, metadata: metaData)
           
        }
        
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "顯示資料", style: .plain, target: self, action: #selector(self.displayCities));
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func displayCities(){
        
    }


}

extension ViewController{
    // UITableViewDataSourece
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
    }
}


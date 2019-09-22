//
//  ViewController.swift
//  ios1
//
//  Created by Robert on 2019/4/2.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    var cities = [[String:Any]]()
    let storage = Storage.storage();
    let db = Firestore.firestore()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib();
        //檢查是否有圖片，沒有就出現上傳圖片資料按鈕
        let imagesRef = storage.reference(withPath: "n135/images/Akihabara.jpg")
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
        let cityCollection = db.collection("cities")
        cityCollection.getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
            guard error == nil, snapshot != nil else{
                return;
            }
            
            for document in snapshot!.documents{
                self.cities.append(document.data())
            }
            self.tableView.reloadData();
            self.navigationItem.leftBarButtonItem = nil;
        }
        
        
            
        
    }
    
    @objc func upLoadCities(){
        let citysPath = Bundle.main.path(forResource: "citylist", ofType: "plist");
        let citys = NSArray(contentsOfFile: citysPath!) as! [[String:Any]];
        let cityCollection = db.collection("cities")
        let storageImageRef = Storage.storage().reference(withPath: "n135/images");
        for city in citys{
            cityCollection.addDocument(data: city) { (error:Error?) in
                if let error = error{
                    print(error)
                }
            }
            let cityImageName = city["Image"] as! String;
            
            let cityImage = UIImage(named: cityImageName);
            let cityImageData = cityImage!.jpegData(compressionQuality: 1.0)
            let imageNameRef = storageImageRef.child(cityImageName);
            let metaData = StorageMetadata();
            metaData.contentType = "image/jpg";
            imageNameRef.putData(cityImageData!, metadata: metaData);
        }
        
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "顯示資料", style: .plain, target: self, action: #selector(self.displayCities))
    }
}

extension ViewController{
    //UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cities.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        let city = cities[indexPath.row]
        let name = city["City"] as! String
        cell.textLabel?.text = name
        let continent = city["Continent"] as! String
        cell.detailTextLabel?.text = continent;
        let imageName = city["Image"] as! String
        let imagePathRef = storage.reference(withPath: "n135/images/\(imageName)")
        imagePathRef .getData(maxSize: 1 * 1024 * 1024) { (data:Data?, error:Error?) in
            if let error = error{
                print("錯誤發生:\(error.localizedDescription)");
            }else{
                let image = UIImage(data: data!)
                cell.imageView?.image = image;
            }
        }
        return cell;
        
    }
    
}


//
//  CitiesViewController.swift
//  ios1
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Firebase



class CitiesViewController: UICollectionViewController {
    var cities = [[String:String]]()
    let storage = Storage.storage();
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.checkN135Node()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func checkN135Node(){
        let citiesRef = Database.database().reference(withPath: "n135/cities");
        citiesRef.observeSingleEvent(of: .value){
            (dataSnapshot:DataSnapshot) -> Void in
            
            if !dataSnapshot.hasChildren() {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "上傳圖片資料", style: .plain, target: self, action: #selector(self.updataCities))
                print("上傳資料");
                
            }else{
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "顯示資料", style: .plain, target: self, action: #selector(self.displayCities))
            }
        }
        
    }
    
    @objc func updataCities(){
        let citysPath = Bundle.main.path(forResource: "citylist", ofType: "plist");
        let citys = NSArray(contentsOfFile: citysPath!) as! [[String:String]];
        let citiesRef = Database.database().reference(withPath: "n135/cities");
        let storageImageRef = Storage.storage().reference(withPath: "n135/images");
        for city in citys{
            citiesRef.childByAutoId().setValue(city);
            let cityImageName = city["Image"]!;
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
    
    @objc func displayCities(){
        let citiesRef = Database.database().reference(withPath: "n135/cities");
        citiesRef.observeSingleEvent(of: .value) { (dataSnapshot:DataSnapshot) in
            guard let value = dataSnapshot.value as? [String:Any] else{
                print("下載轉檔錯誤");
                return
            }
            self.cities = Array(value.values) as! [[String:String]]
            self.collectionView.reloadData();
            self.navigationItem.leftBarButtonItem = nil;
            
        }
    }

    

}

extension CitiesViewController{
    //UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! CityCell
        let city = cities[indexPath.row]
        cell.nameLabel.text = city["City"]
        cell.countryLabel.text = city["Country"]
        cell.continentLabel.text = city["Continent"]
        let imagePathRef = storage.reference(withPath: "n135/images/\(city["Image"]!)")
        imagePathRef .getData(maxSize: 1 * 1024 * 1024) { (data:Data?, error:Error?) in
            if let error = error{
                print("錯誤發生:\(error.localizedDescription)");
            }else{
                let image = UIImage(data: data!)
                cell.imageView.image = image;
            }
        }
        
        return cell;
    }
}




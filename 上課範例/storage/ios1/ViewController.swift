//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/29.
//

import UIKit
import Firebase

class ViewController: UICollectionViewController {
    let firestore = Firestore.firestore()
    let storage = Storage.storage()
    
    //抓下firestor的資料來的資料
    lazy var queryDocuments:[QueryDocumentSnapshot] = {
        //取得所有collection的documents
       
        firestore.collection("cities").getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
            guard let snapshot = snapshot, error == nil else{
                print("資料取得失敗")
                return
            }
            var queryDocuments = snapshot.documents
            self.queryDocuments = queryDocuments
            self.collectionView.reloadData()
           }
        
        return [QueryDocumentSnapshot]()
    }()
    
    
    //closure的執行,只會執行一次
    lazy var cities:[[String:String]] = {
        let pathURL = Bundle.main.url(forResource: "citylist", withExtension: "plist")!
        let cities = NSArray(contentsOf: pathURL) as! [[String:String]]
        return cities
    }()
    

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
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "匯入資料", style: .plain, target: self, action: #selector(self.uploadStoreData(_:)))
            }else{
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "顯示資料", style: .plain, target: self, action: #selector(self.displayCities(_:)))
            }
        }
        
        
    }
    
    

    @objc func uploadStoreData(_ sender:UIBarButtonItem){
        let batch = firestore.batch()
        for city in cities{
            let documentRef = firestore.collection("cities").document()
            batch.setData(city, forDocument: documentRef)
        }
        
        batch.commit { (error:Error?) in
            if error == nil{
                print("批次上傳Firestore成功")
                self.uploadImage()
            }else{
                print("批次上傳Firestore失敗")
            }
        }
        
        
    }
    
    func uploadImage(){
        let storageImageRef = storage.reference(withPath: "h2/images")
        for city in cities{
            let cityImageName = city["Image"]!;
            let cityImage = UIImage(named: cityImageName)!
            if let cityImageData = cityImage.jpegData(compressionQuality: 1.0){
                let imageNameRef = storageImageRef.child(cityImageName)
                let metaData = StorageMetadata();
                metaData.contentType = "image/jpg"
                imageNameRef.putData(cityImageData, metadata: metaData)
            }
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "顯示資料", style: .plain, target: self, action: #selector(displayCities(_:))
           )
        }
    }
    
    @objc func displayCities(_ sender:UIBarButtonItem){
        let _ = self.queryDocuments
    }
}

extension ViewController{
    //MARK: - UICollectionviewDataSource
    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int{
        return self.queryDocuments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let index = indexPath.row
        let queryDocumentSnapshot = queryDocuments[index]
        guard let cityData = queryDocumentSnapshot.data() as? [String:String] else{
            print("沒有取出資料")
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! CityCell
        cell.cityNameLabel.text = cityData["City"]
        let imageName = cityData["Image"]
        let imagePathRef = storage.reference(withPath: "h2/images/\(imageName!)")
        imagePathRef.getData(maxSize: 1*1024*1024) { (data:Data?, error:Error? ) in
            guard let data = data, error == nil else{
                print("圖片下載錯誤")
                return;
            }
            guard let image = UIImage(data: data) else{
                return
            }
            cell.cityImageView.image = image
            
        }
        
        return cell
    }
    
    
}


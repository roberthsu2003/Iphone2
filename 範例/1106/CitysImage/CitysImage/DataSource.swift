//
//  DataSource.swift
//  CitysImage
//
//  Created by 徐國堂 on 2019/11/4.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import Foundation
import Firebase

class DataSource{
    var firestore = Firestore.firestore()
    var storage = Storage.storage()
    var createUpLoadButton:(() -> Void)!
    var createImageUPLoadButton:(() -> Void)!
    
    
    static var dataSource:DataSource = {
        print("執行");
        return DataSource();
    }()
    
    private init(){
        checkDataInFirestore()
    }
    
    func checkDataInFirestore(){
        firestore.collection("citys").addSnapshotListener { (snapshot:QuerySnapshot?, error:Error?) in
            guard error == nil else{
                print("error:\(error!.localizedDescription)");
                return
            }
            
            guard let snapshot = snapshot else{
                print("snapshot是nil");
                return
            }
            
            if snapshot.isEmpty{
                
                print("snapshot是empty");
                if self.createUpLoadButton != nil {
                    self.createUpLoadButton();
                }
                
            }
            
            
        }
    }
    
    func uploadDataToFireStore(){
        print("uploadDataToFireStore");
        guard let cityListPath = Bundle.main.path(forResource: "citylist", ofType: "plist") else{
            print("解析citylist路徑出錯");
            return
        }
        
        guard let cityList = NSArray(contentsOfFile: cityListPath) as? [[String:String]] else{
            print("解析citylist的陣列出錯");
            return
        }
        let batch = firestore.batch();
        for cityItem in cityList{
            //開始上傳資料
            let documentRef = firestore.collection("citys").document();
            batch.setData(cityItem, forDocument: documentRef)
        }
        
        batch.commit { (error:Error?) in
            guard error == nil else{
                print("batch commit出錯:\(error!.localizedDescription)");
                return
            }
            
            print("資料已經全部上傳至firestore citys");
            let cityImagesRef = self.storage.reference(withPath: "cityImages")
            cityImagesRef.getData(maxSize: 1024*1024) { (data:Data?, error:Error?) in
                guard data != nil else{
                    print("data是nil");
                    //出現上傳圖片的按鈕
                    self.createImageUPLoadButton();
                    return;
                }
                
                guard error == nil else{
                    print("error:\(error!.localizedDescription)");
                    return
                }
                
            
            }
        
        }
    }
}

//
//  ViewController.swift
//  googleLogin
//
//  Created by 徐國堂 on 2019/10/30.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    let storage = Storage.storage();
    override func viewDidLoad() {
        super.viewDidLoad()
        guard Auth.auth().currentUser != nil else{
            //沒有登入會執行這裏
            performSegue(withIdentifier: "goLogin", sender: nil);
            let rootURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            print("path:\(rootURL.path)");
            return;
        }
        
        
        //登入會執行這裏
        //print(Auth.auth().currentUser?.uid);
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIApplication.willResignActiveNotification, object: self, queue: nil) { _ in
            print("進入背景");
        }
        
        notificationCenter.addObserver(forName: UIApplication.willEnterForegroundNotification, object: self, queue: nil) { _ in
            print("進入前端");
        }
        guard let user = Auth.auth().currentUser else{
            //使用都尚未登入
            performSegue(withIdentifier: "goLogin", sender: nil);
            return
        }
        
        print("user uid:\(user.uid)");
        guard let citysDbURL = getCitysDbURLFromDocuments(),let cityDbRefFromUserId = getCityDbReferenceFromUserId() else{
            //print("從root下載");
                let rootRef = storage.reference(withPath: "student/citys.db")
                rootRef.getData(maxSize: 100 * 1024 * 1024) { (data:Data?, error:Error?) in
                    //非同步
                    guard let cityDbData = data, error == nil else{
                        print("cityDbData下載錯誤");
                        return
                    }
                    print("cityDbData下載成功");
                    
                    if self.saveCityDbToDocuments(cityData: cityDbData){
                        let privateCityDbRef = self.storage.reference(withPath: "student/\(Auth.auth().currentUser!.uid)/citys.db")
                        let dbMetaData = StorageMetadata();
                        dbMetaData.contentType = "application/octet-stream"
                        privateCityDbRef.putData(cityDbData, metadata: dbMetaData) { (metadata:StorageMetadata?, error:Error?) in
                            guard metadata != nil, error == nil else{
                                print("上傳失敗");
                                return
                            }
                        }
                        print("上傳成功");
                    }
                    
                    
                    
            }
            return
        }
        
    }
    
    

    func getCitysDbURLFromDocuments() -> URL?{
        let fileManager = FileManager.default
        let rootURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataFolderURL = rootURL.appendingPathComponent("data", isDirectory: true)
        let cityDbUrl = dataFolderURL.appendingPathComponent("citys.db")
        guard fileManager.fileExists(atPath: cityDbUrl.path) else{
            //沒有發現citys.db
            //下載citydb
            print("沒有發現city.db");
            return nil;
        }
        return cityDbUrl;
    }
    
    func getCityDbReferenceFromUserId() -> StorageReference?{
        var privateCityDbRef:StorageReference? = storage.reference(withPath: "student/\(Auth.auth().currentUser!.uid)/citys.db")
        privateCityDbRef?.getMetadata(completion: { (metaData:StorageMetadata?, error:Error?) in
            if error != nil{
                if(error! as NSError).domain == StorageErrorDomain{
                    privateCityDbRef = nil;
                }
            }
        })
        return privateCityDbRef;
    }
    
    func saveCityDbToDocuments(cityData:Data) -> Bool{
        if getCitysDbURLFromDocuments() == nil{
        //沒有這個檔
        //建立目錄
        let fileManager = FileManager.default;
        let rootURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataFolderURL = rootURL.appendingPathComponent("data", isDirectory: true)
        print("path:\(dataFolderURL.path)")
        do{
        try fileManager.createDirectory(at: dataFolderURL, withIntermediateDirectories: true, attributes: nil)
        }catch let error as NSError{
            print("建立目錄失敗:\(error.localizedDescription)");
            return false;
        }
        print("目錄建立成功");
        let citysDbUrl = dataFolderURL.appendingPathComponent("citys.db")
        do{
        try cityData.write(to: citysDbUrl)
        }catch let error as NSError{
            print("存檔db失敗:\(error.localizedDescription)");
            return false;
        }
        return true;
    
    }else{
        return true;
    }
  }
}


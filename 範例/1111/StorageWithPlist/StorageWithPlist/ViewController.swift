//
//  ViewController.swift
//  StorageWithPlist
//
//  Created by 徐國堂 on 2019/11/8.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    var uid:String!
    let plistName = "citylist.plist"
    var citys = [[String:String]]()
    var storage = Storage.storage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLogin()
        getPlistFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) { (notification:Notification) in
            print("App進入將進入背景");
            self.uploadCityPlistToPrivateStorage()
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { (notification:Notification) in
            self.downloadPrivateCityPlistToDocuments();
            print("App將進入前景");
        }
    }
    
    func downloadPrivateCityPlistToDocuments(){
        print("download");
        let plistRef = storage.reference(withPath: "h2/\(Auth.auth().currentUser!.uid)/\(plistName)")
        plistRef.getData(maxSize: 1 * 1024 * 1024) { (data:Data?, error:Error?) in
            guard let plistData = data, error == nil else{
                print("下載plsit失敗");
                return
            }
            let fileManager = FileManager.default;
                     guard var plistUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
                         print("url有錯誤");
                         return
                     }
            plistUrl.appendPathComponent(self.plistName)
            do{
                try plistData.write(to: plistUrl)
                print("plist下載成功");
                self.tableView.reloadData();
            }catch let error as NSError{
                print("plist下載失敗")
                print(error.localizedDescription);
            }
        }
    }
    
    func uploadCityPlistToPrivateStorage(){
       let fileManager = FileManager.default;
               guard var plistUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
                   print("url有錯誤");
                   return
               }
      plistUrl.appendPathComponent(plistName)
      let plistRef = storage.reference(withPath: "h2/\(Auth.auth().currentUser!.uid)/\(plistName)")
        //上傳plist
        let metadata = StorageMetadata()
        metadata.contentType = "application/octet-stream"
        plistRef.putFile(from:  plistUrl, metadata: metadata) { (metadata:StorageMetadata?, error:Error?) in
            guard metadata != nil, error == nil else{
                print("上傳plist失敗");
                return
            }
            
            print("上傳plist成功");
        }
        
        plistRef.getMetadata { (metadata:StorageMetadata?, error:Error?) in
            guard metadata != nil, error == nil else{
                //錯誤
                if (error! as NSError).domain == StorageErrorDomain{
                    print("檔案沒有發現");
                    
                    //上傳圖片
                    guard var imagesUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
                        print("url有錯誤");
                        return
                    }
                    imagesUrl.appendPathComponent("images")
                    do{
                        let imageUrls = try fileManager.contentsOfDirectory(at: imagesUrl, includingPropertiesForKeys: nil, options: .includesDirectoriesPostOrder)
                        for imageURL in imageUrls {
                           let imageName = imageURL.lastPathComponent
                           let imageRef = self.storage.reference(withPath: "h2/\(Auth.auth().currentUser!.uid)/images/\(imageName)")
                            let imageMataData = StorageMetadata();
                            imageMataData.contentType = "image/jpeg"
                            imageRef.putFile(from: imageURL, metadata: imageMataData) { (metadata:StorageMetadata?, error:Error?) in
                                guard metadata != nil,error == nil else{
                                    print("上傳圖片出錯");
                                    return
                                }
                                print("上傳圖片成功");
                            }
                        }
                    }
                    catch let error as NSError{
                        print(error.localizedDescription)
                    }
                    
                }

             
                return
            }
            
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func userLogin(){
        guard let user = Auth.auth().currentUser else{
            Auth.auth().signInAnonymously { (resuld:AuthDataResult?, error:Error?) in
                guard resuld != nil, error == nil else{
                    print("暱名登入失敗");
                    return
                }
                print("暱名登入成功");
            }
            
            return
        }
        uid = user.uid
        print("uid=\(uid!)")
    }
    
    func getPlistFile(){
        //check Documents 有沒有citylist.plist
        let fileManager = FileManager.default;
        guard var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            print("url有錯誤");
            return
        }
        url.appendPathComponent(plistName)
        print(url.path);
        
        if !fileManager.fileExists(atPath: url.path){
            print("沒有citylist.plist");
            //下載公用版的plist
            downloadPublicPlistAndSave(plistURL: url)
        }else{
            //getCitylistFromDocuments
            getCitylistFromDocuments()
        }
        
    }
    
    func downloadPublicPlistAndSave(plistURL:URL){
        //下載storang -> h2/cityPlist
        let plistRef = Storage.storage().reference(withPath: "h2/\(plistName)")
        plistRef.getData(maxSize: 1024*1024) { (data:Data?, error:Error?) in
            guard let plistData = data,error == nil else{
                print("下載有錯誤");
                return;
            }
            
            //let plistString = String(data: plistData, encoding: .utf8)
            do{
             try plistData.write(to: plistURL)
            }catch let error as NSError{
                print("寫入plistToDocument有誤:\(error.localizedDescription)");
            }
            print("下載儲存完成")
            //created images directory in Documents
            self.createImagesDirectoryInDocuments()
            self.getCitylistFromDocuments()
        }
    }
    
    func createImagesDirectoryInDocuments(){
        let fileManager = FileManager.default;
        guard var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            print("url有錯誤");
            return
        }
        url.appendPathComponent("images", isDirectory: true);
        do{
        try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            print("建立images的目錄成功");
        }catch let error as NSError{
            print("建立images的目錄失敗:\(error.localizedDescription)")
        }
        
       
       
    }
    
    func getCitylistFromDocuments(){
        let fileManager = FileManager.default;
        guard var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            print("url有錯誤");
            return
        }
        url.appendPathComponent(plistName)
        guard let citys = NSArray(contentsOf: url) as? [[String:String]] else{
            print("轉Array失敗");
            return;
        }
        self.citys = citys;
        
        tableView.reloadData();
    }

    
    func getImageInDocument(imageName:String,indexPath:IndexPath) -> UIImage?{
        let fileManager = FileManager.default;
        guard var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            print("url有錯誤");
            return nil
        }
        url.appendPathComponent("images", isDirectory: true);
        url.appendPathComponent(imageName)
        if !fileManager.fileExists(atPath: url.path){
            //沒有這張圖
            downloadImageFromStorageToDocuments(imageName: imageName, locationInDocuments: url,indexpath:indexPath)
            return nil;
        }else{
           //有這一張圖
            return UIImage(contentsOfFile: url.path)!
        }
    }
    
    
    func downloadImageFromStorageToDocuments(imageName:String,locationInDocuments:URL,indexpath:IndexPath){
        let imageRef = storage.reference(withPath: "h2/images/\(imageName)")
        imageRef.getData(maxSize: 1 * 1024 * 1024) { (data:Data?, error:Error?) in
            guard let imageData = data, error == nil else{
                print("下載失敗");
                return;
            }
            do{
                try imageData.write(to: locationInDocuments)
                self.tableView.reloadRows(at: [indexpath], with: .automatic)
            }catch let error as NSError{
                print("寫入失敗:\(error.localizedDescription)");
                
            }
        }
    }
    


}

extension ViewController{
    //UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return citys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        let cityDic = citys[indexPath.row]
        let imageName = cityDic["Image"]
        let image = getImageInDocument(imageName: imageName!,indexPath:indexPath )
        cell.textLabel?.text = cityDic["City"]
        cell.detailTextLabel?.text = cityDic["Country"]
        cell.imageView?.image = image;
        return cell;
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        deleteOneCityData(indexPath: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func deleteOneCityData(indexPath:IndexPath){
        let deleteIndex = indexPath.row;
        let cityImageName = citys[deleteIndex]["Image"]
        citys.remove(at: deleteIndex)
        //更新plist資料
        let fileManager = FileManager.default;
        guard var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            print("url有錯誤");
            return
        }
        var plistURL = url
        plistURL.appendPathComponent(plistName)
        (citys as NSArray).write(to: url, atomically: true)
        
        print("Document的內容被更改");
        //delete images
        var imageURL = url
        imageURL.appendPathComponent("images", isDirectory: true)
        imageURL.appendPathComponent(cityImageName!)
        do{
           try fileManager.removeItem(at: imageURL)
        }catch let error as NSError{
            print("刪documents內的圖片失敗:\(error.localizedDescription)");
        }
        
        //刪除雲端的圖片
        let imageRef = storage.reference(withPath: "h2/\(Auth.auth().currentUser!.uid)/images/\(cityImageName!)")
        
        imageRef.delete { (error:Error?) in
            guard error == nil else{
                print("delecte fireStorage 失敗");
               
                return
            }
            print("delete 成功");
            
            
        }
        
        
        
    }
}






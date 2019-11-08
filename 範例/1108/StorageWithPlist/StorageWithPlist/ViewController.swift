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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLogin()
        getPlistFile()
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

    
    func getImageInDocument(imageName:String) -> UIImage?{
        let fileManager = FileManager.default;
        guard var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            print("url有錯誤");
            return nil
        }
        url.appendPathComponent("images", isDirectory: true);
        url.appendPathComponent(imageName)
        print(url.path)
        return nil;
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
        let image = getImageInDocument(imageName: imageName!)
        cell.textLabel?.text = cityDic["City"]
        cell.detailTextLabel?.text = cityDic["Country"]
        return cell;
        
    }
}






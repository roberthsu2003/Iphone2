//
//  ViewController.swift
//  publicPrivateStorage
//
//  Created by 徐國堂 on 2019/11/10.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UITableViewController {
    let storage = Storage.storage()
    var citys = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard userAuthentication() == true,checkCityplistInDocuments() == true else {
            print("出錯");
            return
           
        }
        /*
        guard let citys = parsePlistInDocument() else{
            return;
        }*/
        
        self.citys = parsePlistInDocument() ?? [[String:String]]()
        print(self.citys)
        self.tableView.reloadData();
    }
    
   
    
    func userAuthentication() -> Bool{
        var boolState = true;
        if Auth.auth().currentUser == nil {
                   //尚未認證
            
            boolState = false;
                   Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                    //非同步執行
                       guard result != nil, error == nil else{
                           print("anoonymously失敗");
                           return
                       }
                        
                        if self.checkCityplistInDocuments(){
                            self.citys = self.parsePlistInDocument() ?? [[String:String]]()
                            self.tableView.reloadData();
                        }
                    
                   }
                 
        }else{
        //已經認證
            boolState = true;
        }
        
       return boolState
    }
    
    func checkCityplistInDocuments() -> Bool{
        var boolState:Bool = true;
        let fileManager = FileManager.default;
       
        guard let plistURL = getCityplistURLInDocument() else{
            boolState = false;
            return boolState;
        }
        if !fileManager.fileExists(atPath: plistURL.path){
            let plistInStorageRef = storage.reference(withPath: "h2/citylist.plist")
            plistInStorageRef.getData(maxSize: 1*1024*1024) { (data:Data?, error:Error?) in
                
                //非同步執行
                guard let plistData = data, error == nil else {
                    print("下載plist檔案有錯");
                    boolState = false;
                    return
                }
                do{
                   try plistData.write(to: plistURL)
                }catch let error as NSError{
                    print("寫入plist有錯:\(error.localizedDescription)")
                    boolState = false;
                    return
                }
                
                guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
                    print("沒有取得documentsURL");
                    boolState = false;
                    return;
                }
                
                let imagesDirectoryURL = documentsURL.appendingPathComponent("images", isDirectory: true)
                do{
                try fileManager.createDirectory(at: imagesDirectoryURL, withIntermediateDirectories: true, attributes: nil)
                   
                    
                }catch let error as NSError{
                    print("建立images Directory有問題:\(error.localizedDescription)");
                    boolState = false;
                    return;
                }
                
                self.citys = self.parsePlistInDocument() ?? [[String:String]]()
                print(self.citys)
                self.tableView.reloadData();
                
                
                
            }
            
        }
        
        return boolState;
    }
    
    func getCityplistURLInDocument() -> URL?{
        let fileManager = FileManager.default;
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            print("沒有取得documentsURL");
            return nil;
        }
        let plistURL = documentsURL.appendingPathComponent("citylist.plist")
        return plistURL
    }
    
    
    
    func parsePlistInDocument() -> [[String:String]]?{
        guard let plistURL = getCityplistURLInDocument() else{
            return nil;
        }
        
        let path = plistURL.path
        
        guard let citys = NSArray(contentsOf: plistURL) as? [[String:String]] else{
            print("解析plist出錯");
            return nil
        }
        
        return citys
        
        
    }


}

extension ViewController{
    //UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return citys.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cityDic = citys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.text = cityDic["City"]
        cell.detailTextLabel?.text = cityDic["Country"]
        if checkImageFileExist(imageName:cityDic["Image"]!) {
            let imageURL = getImageURLInDocuments(imageName: cityDic["Image"]!)
            cell.imageView?.image = UIImage(contentsOfFile: imageURL.path)
        }else{
            //fireStorage downloadImage
            
        }
        /*
        guard let cityImage = UIImage(named: cityDic["Image"]!) else{
            
        }
 */
        
        return cell;
        
    }
    
    func getImageURLInDocuments(imageName:String) -> URL{
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let imageFolderURL = documentURL.appendingPathComponent("images", isDirectory: true)
        let imageURL = imageFolderURL.appendingPathComponent(imageName)
        print(imageURL.path)
        return imageURL
    }
    
    func checkImageFileExist(imageName:String) -> Bool{
         let imageURL = getImageURLInDocuments(imageName: imageName)
        if FileManager.default.fileExists(atPath: imageURL.path) {
            return true;
        }
        return false;
    }
    
    
}


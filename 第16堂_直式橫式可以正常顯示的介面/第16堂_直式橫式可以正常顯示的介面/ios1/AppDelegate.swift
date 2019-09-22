//
//  AppDelegate.swift
//  ios1
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    override init() {
        super.init()
        FirebaseApp.configure();
        //login
        Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
            guard let result = result,error == nil else{
                print("login錯誤");
                return;
            }
            print("login成功");
            if result.user.isAnonymous {
                self.checkN135Node();
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        

        
       
        return true
    }

    func checkN135Node(){
         let citiesRef = Database.database().reference(withPath: "n135/cities");
        citiesRef.observeSingleEvent(of: .value){
            (dataSnapshot:DataSnapshot) -> Void in
            
            if !dataSnapshot.hasChildren() {
                print("上傳資料");
                self.updataCities();
            }else{
                print("有資料");
            }
        }
       
    }
    
    func updataCities(){
        let citysPath = Bundle.main.path(forResource: "citylist", ofType: "plist");
        let citys = NSArray(contentsOfFile: citysPath!) as! [[String:String]];
        let citiesRef = Database.database().reference(withPath: "n135/cities");
        let storageImageRef = Storage.storage().reference(withPath: "n135/images");
        for city in citys{
            citiesRef.childByAutoId().setValue(city);
            let cityImageName = city["Image"]!;
            let cityImage = UIImage(named: cityImageName);
            //let cityImageData = UIImageJPEGRepresentation(cityImage!, 1.0);
            let cityImageData = cityImage?.jpegData(compressionQuality: 1.0)
            let imageNameRef = storageImageRef.child(cityImageName);
            let metaData = StorageMetadata();
            metaData.contentType = "image/jpg";
            imageNameRef.putData(cityImageData!, metadata: metaData);
        }
    }

}


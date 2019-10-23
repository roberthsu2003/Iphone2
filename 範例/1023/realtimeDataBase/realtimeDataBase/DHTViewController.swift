//
//  DHTViewController.swift
//  realtimeDataBase
//
//  Created by 徐國堂 on 2019/10/21.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class DHTViewController: UIViewController {
    @IBOutlet var HumidityField:UITextField!
    @IBOutlet var FahrenheitField:UITextField!
    @IBOutlet var FahrenheitIndexField:UITextField!
    @IBOutlet var CelsiusField:UITextField!
    @IBOutlet var CelsiusIndexField:UITextField!
    var handle:AuthStateDidChangeListenerHandle!
    
    var DHTref:DatabaseReference = Database.database().reference(withPath: "DHT")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DHTref.observe(.value, with: { (snapshot:DataSnapshot) in
           let dhtDict = snapshot.value as! [String:String]
            if self.HumidityField.text != "濕度:\(dhtDict["Humidity"] ?? "不明")"{
                let newValue = "濕度:\(dhtDict["Humidity"] ?? "不明")"
                self.delay(targetField: self.HumidityField, changeValue: newValue)
            }
            if self.FahrenheitField.text != "華氏:\(dhtDict["Fahrenheit"] ?? "不明")"{
                let newValue = "華氏:\(dhtDict["Fahrenheit"] ?? "不明")"
                self.delay(targetField: self.FahrenheitField, changeValue: newValue)
            }
            if self.FahrenheitIndexField.text != "華氏指數:\(dhtDict["FahrenheitIndex"] ?? "不明")"{
                let newValue = "華氏指數:\(dhtDict["FahrenheitIndex"] ?? "不明")"
                self.delay(targetField: self.FahrenheitIndexField, changeValue: newValue)
            }
            if self.CelsiusField.text != "攝氏:\(dhtDict["Celsius"] ?? "不明")"{
                let newValue = "攝氏:\(dhtDict["Celsius"] ?? "不明")"
                self.delay(targetField: self.CelsiusField, changeValue: newValue)
            }
            if self.CelsiusIndexField.text != "攝氏指數:\(dhtDict["CelsiusIndex"] ?? "不明")"{
                let newValue = "攝氏指數:\(dhtDict["CelsiusIndex"] ?? "不明")"
                self.delay(targetField: self.CelsiusIndexField, changeValue: newValue)
            }
            
        }) { (error:Error) in
            print("error:\(error.localizedDescription)");
        }
        
        
    }
    
    func delay(targetField field:UITextField,changeValue value:String){
        field.textColor = UIColor.red;
        field.text = value;
        let when = DispatchTime.now() + 0.5;
        DispatchQueue.main.asyncAfter(deadline: when) {
            field.textColor = UIColor.black
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth:Auth, user:User?) in
            if let user = user {
               //已經登入
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登出", style: .plain, target: self, action: #selector(self.userLogout(_:)))
                print(user.uid);
            }else{
                //尚未登入
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登入", style: .plain, target: self, action: #selector(self.userLogin(_:)))
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    @objc func userLogout(_ sender:UIBarButtonItem){
        guard  (try? Auth.auth().signOut()) != nil else{
            print("登出失敗");
            return
        }
        print("登出成功");
    }
    
    @objc func userLogin(_ sender:UIBarButtonItem){
        Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
            guard error == nil, result != nil else{
                print("暱名登入有錯誤:\(error!.localizedDescription)");
                return
            }
            
            let user = result!.user
            if user.isAnonymous {
                print("暱名登入成功")
            }
            
        }
    }

}

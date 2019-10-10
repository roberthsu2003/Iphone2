//
//  DHTViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2017/10/31.
//  Copyright © 2017年 Gjun. All rights reserved.
//

import UIKit
import Firebase

class DHTViewController: UIViewController {
    lazy var DHTref:DatabaseReference! = Database.database().reference(withPath: "DHT");
    
    @IBOutlet weak var HumidityField: UITextField!
    @IBOutlet weak var FahrenheitField: UITextField!
    @IBOutlet weak var FahrenheitIndexField: UITextField!
    @IBOutlet weak var CelsiusField: UITextField!
    @IBOutlet weak var CelsiusIndexField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DHTref.observe(.value, with: {
            (datasnapshot:DataSnapshot) -> Void in
            if let dhtDict = datasnapshot.value as? [String:String]{
               
                if self.HumidityField.text != "濕度:\(dhtDict["Humidity"] ?? "不明")"{
                    let newValue = "濕度:\(dhtDict["Humidity"] ?? "不明")"
                    self.delay(targetField: self.HumidityField, changedValue: newValue);
                }
                if  self.FahrenheitField.text != "華氏:\(dhtDict["Fahrenheit"] ?? "不明")"{
                    let newValue = "華氏:\(dhtDict["Fahrenheit"] ?? "不明")";
                    self.delay(targetField: self.FahrenheitField, changedValue: newValue);
                }
                if self.FahrenheitIndexField.text != "華氏指數:\(dhtDict["FahrenheitIndex"] ?? "不明")"{
                    let newValue = "華氏指數:\(dhtDict["FahrenheitIndex"] ?? "不明")";
                    self.delay(targetField: self.FahrenheitIndexField, changedValue: newValue);
                }
                if self.CelsiusField.text != "攝氏:\(dhtDict["Celsius"] ?? "不明")"{
                    let newValue = "攝氏:\(dhtDict["Celsius"] ?? "不明")";
                    self.delay(targetField: self.CelsiusField, changedValue: newValue);
                }
                if self.CelsiusIndexField.text != "攝氏指數:\(dhtDict["CelsiusIndex"] ?? "不明")"{
                    let newValue = "攝氏指數:\(dhtDict["CelsiusIndex"] ?? "不明")";
                    self.delay(targetField: self.CelsiusIndexField, changedValue: newValue);
                }
            }
        });
    }
    
    func delay(targetField field:UITextField,changedValue value:String){
        field.textColor = UIColor.red;
        field.text = value;
        let when = DispatchTime.now() + 0.5;
        DispatchQueue.main.asyncAfter(deadline: when){
            field.textColor = UIColor.black;
            field.text = value;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

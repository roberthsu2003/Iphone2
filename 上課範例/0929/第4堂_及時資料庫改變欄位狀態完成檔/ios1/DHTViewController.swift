//
//  DHTViewController.swift
//  ios1
//
//  Created by Robert on 2019/9/22.
//  Copyright © 2019 Gjun. All rights reserved.
//

import UIKit
import Firebase

class DHTViewController: UITableViewController {
    @IBOutlet var textFields:[UITextField]!;
    @IBOutlet var humidityField:UITextField!;
    @IBOutlet var fahrenheitField:UITextField!;
    @IBOutlet var fahrenheitIndexField:UITextField!;
    @IBOutlet var celsiusField:UITextField!;
    @IBOutlet var celsiusIndexField:UITextField!;
    
    var DHTref:DatabaseReference = Database.database().reference(withPath: "DHT")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false;
        tableView.bounces = false;
        /*
        for textField in textFields{
            textField.isEnabled = false;
            textField.text = "10.10c"
        }
 */
        
        DHTref.observe(DataEventType.value){
            (snapshot:DataSnapshot) -> Void in
            let dhtDict = snapshot.value as? [String:String] ?? [String:String]();
            var newValue:String;
           
            if self.humidityField.text != "\(dhtDict["Humidity"] ?? "不明")"{
                newValue = dhtDict["Humidity"] ?? "不明";
                
                self.delay(targetField: self.humidityField, chageValue: newValue)
            }
            
            
            print(self.fahrenheitField.text);
            if self.fahrenheitField.text != "\(dhtDict["Fahrenheit"] ?? "不明")"{
                newValue = dhtDict["Fahrenheit"] ?? "不明";
                          //self.humidityField.text = newValue;
                          self.delay(targetField: self.fahrenheitField, chageValue: newValue)
            }
           
            
            if self.fahrenheitIndexField.text != "\(dhtDict["FahrenheitIndex"] ?? "不明")"{
                newValue = dhtDict["FahrenheitIndex"] ?? "不明";
                           //self.humidityField.text = newValue;
                           self.delay(targetField: self.fahrenheitIndexField, chageValue: newValue)
            }
            
            
            if self.celsiusField.text != "\(dhtDict["Celsius"] ?? "不明")"{
                newValue = dhtDict["Celsius"] ?? "不明";
                           //self.humidityField.text = newValue;
                           self.delay(targetField: self.celsiusField, chageValue: newValue)
            }
            
            
            if self.celsiusIndexField.text != "\(dhtDict["CelsiusIndex"] ?? "不明")"{
                newValue = dhtDict["CelsiusIndex"] ?? "不明";
                           //self.humidityField.text = newValue;
                           self.delay(targetField: self.celsiusIndexField, chageValue: newValue)
            }
            
        }
        
    }
    
    func delay(targetField field:UITextField,chageValue value:String){
        field.textColor = UIColor.red;
        field.text = value;
        //暫停10秒
        let when = DispatchTime.now() + 0.5;
        DispatchQueue.main.asyncAfter(deadline: when){
            field.textColor = UIColor.black
            field.text = value;
        }
        
    }
    

   
}

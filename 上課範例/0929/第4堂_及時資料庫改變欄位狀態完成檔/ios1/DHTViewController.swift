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
        for textField in textFields{
            textField.isEnabled = false;
            textField.text = "10.10c"
        }
        
        DHTref.observe(DataEventType.value){
            (snapshot:DataSnapshot) -> Void in
            let dhtDict = snapshot.value as? [String:String] ?? [String:String]();
            let newValue = dhtDict["Humidity"] ?? "不明";
            self.humidityField.text = newValue;
        }
        
    }
    

   
}

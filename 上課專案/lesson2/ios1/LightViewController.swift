//
//  LightViewController.swift
//  ios1
//
//  Created by Robert on 2019/4/15.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class LightViewController: UIViewController {
    @IBOutlet var lightBtn:UIButton!;
    var relayRef:DatabaseReference!;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        relayRef = Database.database().reference(withPath: "Relay")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let relayHandler = relayRef.observe(.value){
            (snapShot:DataSnapshot) in
            let relayValue = snapShot.value as? [String:Bool]
            if relayValue != nil{
                print(relayValue!["D1"]!)
            }
            
        }
    }
    

   

}

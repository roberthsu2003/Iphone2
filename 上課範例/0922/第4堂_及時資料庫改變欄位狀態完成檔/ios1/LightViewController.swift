//
//  LightViewController.swift
//  ios1
//
//  Created by Robert on 2019/9/22.
//  Copyright © 2019 Gjun. All rights reserved.
//

import UIKit
import Firebase

class LightViewController: UIViewController {
    @IBOutlet var lightBtn:UIButton!
    var relayRef = Database.database().reference().child("Relay");
    var relayHandle:UInt!;
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let relayHandle = relayRef.observeSingleEvent(of: .value){
            (snapshot:DataSnapshot) -> Void in
            let relayNode = snapshot.value as! [String: Bool]
            let d1Value = relayNode["D1"]!
            if d1Value{
                self.lightBtn.setImage(UIImage(named: "open_light"), for: .normal)
            }else{
                self.lightBtn.setImage(UIImage(named: "close_light"), for: .normal)
            }
        }
 */
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        relayHandle = relayRef.observe(.value) { (snapshot:DataSnapshot) in
            let relayNode = snapshot.value as! [String: Bool]
            let d1Value = relayNode["D1"]!
            if d1Value{
                self.lightBtn.setImage(UIImage(named: "open_light"), for: .normal)
            }else{
                self.lightBtn.setImage(UIImage(named: "close_light"), for: .normal)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
    }
    
    
    @IBAction func userClick(_ sender:UIButton){
        relayRef.observeSingleEvent(of: .value){
            (snapshot:DataSnapshot) -> Void in
            let relayNode = snapshot.value as! [String: Bool]
            let d1Value = relayNode["D1"]!
            self.relayRef.setValue(["D1":!d1Value]);
            
        }
    }
    

   

}

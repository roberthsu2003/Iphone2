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
        lightBtn.addTarget(self, action: #selector(userChangeState(_:)), for: UIControl.Event.touchUpInside)
        
        relayRef.observe(.value){
            (snapshot:DataSnapshot) in
            //print(snapshot.value ?? "沒有東西")
            //optional binding
            if let relayValue = snapshot.value as? [String:Bool]{
               let d1State = relayValue["D1"]!//force unwrapping
                if d1State {
                    self.navigationItem.prompt = "目前狀態:開啟";
                    self.lightBtn.setImage(UIImage.init(named: "open_light"), for: UIControl.State.normal)
                }else{
                    self.navigationItem.prompt = "目前狀態:關閉";
                    self.lightBtn.setImage(UIImage.init(named: "close_light"), for: UIControl.State.normal)
                }
            }else{
                print("連線有問題");
            }
            
        }
    }
    
    @objc func userChangeState(_ btn:UIButton){
        relayRef.observeSingleEvent(of: DataEventType.value) { (snapshot:DataSnapshot) in
            if let relayValue = snapshot.value as? [String:Bool]{
                let d1Value = relayValue["D1"]!
                self.relayRef.setValue(["D1":!d1Value])
            }
        }
    }
   

}

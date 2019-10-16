//
//  LightViewController.swift
//  realtimeDataBase
//
//  Created by 徐國堂 on 2019/10/16.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class LightViewController: UIViewController {
    @IBOutlet var lightBtn:UIButton!
    var relay1Ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        relay1Ref = Database.database().reference(withPath: "Relay1/D1")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func userChangeLight(_ sender:UIButton){
        relay1Ref.observeSingleEvent(of: .value){
            (snapshot:DataSnapshot) -> Void in
            if let d1State = snapshot.value as? Bool{
                self.relay1Ref.setValue(!d1State)
            }else{
                print("取得錯誤");
            }
        }
    }

}

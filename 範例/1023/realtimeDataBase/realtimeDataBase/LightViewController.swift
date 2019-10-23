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
    var registerValue:UInt!;
    override func viewDidLoad() {
        super.viewDidLoad()
        relay1Ref = Database.database().reference(withPath: "Relay1/D1")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       registerValue = relay1Ref.observe(.value){
            (snapShot:DataSnapshot) -> Void in
            if let d1Value = snapShot.value as? Bool{
                print("新的d1值是:\(d1Value)");
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        relay1Ref.removeObserver(withHandle:registerValue)
    }
    

    @IBAction func userChangeLight(_ sender:UIButton){
        relay1Ref.observeSingleEvent(of: .value){
            (snapshot:DataSnapshot) -> Void in
            if let d1State = snapshot.value as? Bool{
                self.relay1Ref.setValue(!d1State) { (error:Error?, d1Ref:DatabaseReference) in
                    if error == nil {
                        if !d1State {
                            self.navigationItem.prompt = "目前狀態:開啟"
                            self.lightBtn.setImage(UIImage.init(named: "open_light"), for: .normal)
                        }else{
                            self.navigationItem.prompt = "目前狀態:關閉"
                            self.lightBtn.setImage(UIImage.init(named: "close_light"), for: .normal)
                        }
                    }
                }
            }else{
                print("取得錯誤");
            }
        }
    }

}

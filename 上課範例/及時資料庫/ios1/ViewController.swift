//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/8.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var lightBtn:UIButton!
    var relayRef:DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            print("登入完成")
            print(Auth.auth().currentUser!.uid)
            doAnotherThing()
            
        } else {
            //暱名登入
            Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                guard let result = result, error == nil else{
                    return
                }
                let user = result.user
               
                if user.isAnonymous{
                    print(user.uid)
                    self.doAnotherThing()
                }
                
            }
        }
        
    }
    
    func doAnotherThing(){
        relayRef = Database.database().reference(withPath: "relay/d1")
        relayRef.observe(.value) { (snapshot:DataSnapshot) in
            let d1Value = snapshot.value as! Bool
            if d1Value {
                self.navigationItem.prompt = "目前狀態:開啟"
                self.lightBtn.setImage(UIImage.init(named: "open_light"), for: .normal)
            }else{
                self.navigationItem.prompt = "目前狀態:關閉"
                self.lightBtn.setImage(UIImage.init(named: "close_light"), for: .normal)
            }
        }
    }
    
    @IBAction func userClick(_ sender:UIButton){
        relayRef.observeSingleEvent(of: .value) { (snapshot:DataSnapshot) in
            let d1State = snapshot.value as! Bool
            self.relayRef.setValue(!d1State)
        }
    }


}


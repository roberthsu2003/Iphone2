//
//  ViewController.swift
//  lesson5
//
//  Created by Robert on 2019/4/24.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    let presidentsRef = Database.database().reference(withPath: "presidents")
    var presidents = [[String:String]]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Auth.auth().currentUser!.uid
        presidentsRef.observe(.value){
            (snapshot:DataSnapshot) in
           self.presidents = snapshot.value as! [[String:String]]
            print("下載完畢")
            print(self.presidents);
            //我的資料下載完畢
        }
        
        print("尚未下載完畢")
        print(self.presidents);
        
    }


}


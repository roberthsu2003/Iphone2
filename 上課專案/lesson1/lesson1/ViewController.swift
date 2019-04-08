//
//  ViewController.swift
//  lesson1
//
//  Created by Robert on 2019/4/8.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var states = [String:[String]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //初始化statedictionary.plish
        /*
        if let path = Bundle.main.path(forResource: "statedictionary", ofType: "plist"){
            print(path);
        }else{
            print("檔案有問題");
        }
 */
        let path = Bundle.main.path(forResource: "statedictionary", ofType: "plist")!
        /*
        let myState = NSDictionary(contentsOfFile: path);
        states = myState as! [String:[String]]
 */
        states = NSDictionary(contentsOfFile: path) as! [String:[String]]
        print(states)
        
        
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }


}


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
    var stateNames = [String]();
    
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
        //print(states)
        //print(states.keys)
        stateNames = [String](states.keys).sorted()
        print(stateNames)
        for name in stateNames{
            print("\(name)州")
            print("================");
            let postNums = states[name]!
            for postNum in postNums{
                print(postNum)
            }
            print("================");
        }
       
        
        
        
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
    }


}


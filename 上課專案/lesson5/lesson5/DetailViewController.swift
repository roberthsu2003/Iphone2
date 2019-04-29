//
//  DetailViewController.swift
//  lesson5
//
//  Created by Robert on 2019/4/29.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var president:[String:String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("president name:\(president["name"]!)")
        print("president url:\(president["url"]!)");
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

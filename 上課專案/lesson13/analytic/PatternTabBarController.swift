//
//  PatternTabBarController.swift
//  analytic
//
//  Created by Robert on 2019/5/22.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit

class PatternTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let favoriteFood  = UserDefaults.standard.value(forKey: "favorite_food") as? String;
        if favoriteFood == nil {
            print("使用者，還沒設定喜歡的食物");
        }
    }
    

   

}

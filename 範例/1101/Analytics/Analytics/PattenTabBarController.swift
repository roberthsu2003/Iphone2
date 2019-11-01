//
//  PattenTabBarController.swift
//  Analytics
//
//  Created by 徐國堂 on 2019/11/1.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class PattenTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        var path = paths.last ?? ""
        
        print(path);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if getUserFavoriteFood() == nil{
            askForFavoriteFood()
        }
    }
    

    func getUserFavoriteFood() -> String?{
        return UserDefaults.standard.value(forKey: "favorite_food") as? String
    }
    
    func askForFavoriteFood(){
        //跳出一個新的撰取畫面
        performSegue(withIdentifier: "goFood", sender: nil)
    }
    
    @IBAction func unwindToHome(_ sender:UIStoryboardSegue){
        
    }

}

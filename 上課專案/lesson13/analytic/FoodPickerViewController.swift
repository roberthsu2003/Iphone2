//
//  FoodPickerViewController.swift
//  analytic
//
//  Created by Robert on 2019/5/22.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit
import Firebase

class FoodPickerViewController: UIViewController {
    let foodStuffs = ["熱狗", "漢飽", "pizza"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
 
}

extension FoodPickerViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return foodStuffs.count
    }
    
}

extension FoodPickerViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return foodStuffs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let food = foodStuffs[row]
        UserDefaults.standard.set(food, forKey: "favorite_food")
        UserDefaults.standard.synchronize();
        //取得sandbox的路徑
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(paths.first!);
        Analytics.setUserProperty(food, forName: "favorite_food")
        dismiss(animated: true, completion: nil);
    }
}

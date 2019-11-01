//
//  FoodPickerViewController.swift
//  Analytics
//
//  Created by 徐國堂 on 2019/11/1.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class FoodPickerViewController: UIViewController {
    let foodStuffs = ["Hot Dogs", "Hamburger", " Pizza"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension FoodPickerViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
        UserDefaults.standard.synchronize()
        performSegue(withIdentifier: "unwindToHome", sender: nil)
        
        
    }
}

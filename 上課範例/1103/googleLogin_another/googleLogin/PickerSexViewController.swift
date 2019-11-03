//
//  PickerSexViewController.swift
//  googleLogin
//
//  Created by 徐國堂 on 2019/11/3.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class PickerSexViewController: UIViewController {
    var sexs = ["Sexs", "Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension PickerSexViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return sexs.count
    }
}

extension PickerSexViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return sexs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if row != 0{
            let selectedValue = sexs[row]
            print("selected Sex:\(selectedValue)");
            UserDefaults.standard.set(selectedValue, forKey: "sex")
            
        }
        
    }
}

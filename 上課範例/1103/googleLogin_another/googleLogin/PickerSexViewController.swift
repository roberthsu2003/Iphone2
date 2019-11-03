//
//  PickerSexViewController.swift
//  googleLogin
//
//  Created by 徐國堂 on 2019/11/3.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class PickerSexViewController: UIViewController {
    var sexs = [ "Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension PickerSexViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
    }
}

extension PickerSexViewController:UIPickerViewDelegate{
    
}

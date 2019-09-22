//
//  RGBViewController.swift
//  
//
//  Created by Robert on 2019/9/22.
//

import UIKit
import Color_Picker_for_iOS;

class RGBViewController: UIViewController {
    var colorPickerView = HRColorPickerView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView.frame = view.frame;
        colorPickerView.color = UIColor.green;
        self.view.addSubview(colorPickerView)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    

}

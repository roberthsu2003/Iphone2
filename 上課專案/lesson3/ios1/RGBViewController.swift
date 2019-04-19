//
//  RGBViewController.swift
//  ios1
//
//  Created by Robert on 2019/4/19.
//  Copyright © 2019 Gjun. All rights reserved.
//ios color picker

import UIKit
import Color_Picker_for_iOS

class RGBViewController: UIViewController {
    var colorPickerView = HRColorPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView.color = UIColor.blue
        colorPickerView.frame = view.frame
        colorPickerView.frame.origin.y = 20
        view.addSubview(colorPickerView)
        colorPickerView.addTarget(self, action: #selector(colorChange(_:)), for: UIControl.Event.valueChanged)
    
    }
    

    @objc func colorChange(_ sender:HRColorPickerView){
        print("change color")
    }
}

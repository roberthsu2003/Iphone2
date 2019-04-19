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
    let colorPickerView = HRColorPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView.color = UIColor.blue
        colorPickerView.frame = view.frame
        colorPickerView.frame.origin.y = 20
        view.addSubview(colorPickerView)
        colorPickerView.addTarget(self, action: #selector(colorChange(_:)), for: UIControl.Event.valueChanged)
    
    }
    

    @objc func colorChange(_ sender:HRColorPickerView){
        var rValue:CGFloat = 0;
        var gValue:CGFloat = 0;
        var bValue:CGFloat = 0;
        var aValue:CGFloat = 0;
        
       colorPickerView.color.getRed(&rValue, green: &gValue, blue: &bValue, alpha: &aValue)
        print("r:\(rValue),g:\(gValue),b:\(bValue),a:\(aValue)");
    }
}

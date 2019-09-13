//
//  RGBViewController.swift
//  ios1
//
//  Created by Robert on 2019/4/19.
//  Copyright © 2019 Gjun. All rights reserved.
//ios color picker

import UIKit
import Firebase
import Color_Picker_for_iOS

class RGBViewController: UIViewController {
    let colorPickerView = HRColorPickerView()
    let rgbRef = Database.database().reference(withPath: "RGB")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView.color = UIColor.blue
        colorPickerView.frame = view.frame
        colorPickerView.frame.origin.y = 20
        view.addSubview(colorPickerView)
        colorPickerView.addTarget(self, action: #selector(colorChange(_:)), for: UIControl.Event.valueChanged)
        rgbRef.observeSingleEvent(of: DataEventType.value) { (snapshot:DataSnapshot) in
        let rgbValues = snapshot.value as! [String:CGFloat]
        let r = rgbValues["R"]!
        let g = rgbValues["G"]!
        let b = rgbValues["B"]!
        self.colorPickerView.color = UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
            
        }
    
    }
    

    @objc func colorChange(_ sender:HRColorPickerView){
        var rValue:CGFloat = 0;
        var gValue:CGFloat = 0;
        var bValue:CGFloat = 0;
        var aValue:CGFloat = 0;
        
       colorPickerView.color.getRed(&rValue, green: &gValue, blue: &bValue, alpha: &aValue)
        let rInt = Int(rValue*255)
        let gInt = Int(gValue*255)
        let bInt = Int(bValue*255)
        rgbRef.setValue([
            "R":rInt,
            "G":gInt,
            "B":bInt,
            ])
    }
}

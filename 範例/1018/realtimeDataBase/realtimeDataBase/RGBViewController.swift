//
//  RGBViewController.swift
//  realtimeDataBase
//
//  Created by 徐國堂 on 2019/10/18.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase
import Color_Picker_for_iOS

class RGBViewController: UIViewController {
    var rgbRef:DatabaseReference!;
    var colorPickerView = HRColorPickerView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbRef = Database.database().reference(withPath: "RGB1")
        colorPickerView.color = UIColor.blue;
        self.view.addSubview(colorPickerView)
                
        colorPickerView.translatesAutoresizingMaskIntoConstraints = false;
        let guide = view.safeAreaLayoutGuide
        let topConstraint = colorPickerView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0)
        let bottomConstraint = colorPickerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0)
        
        let leadConstraint = colorPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        
        let trailConstraint = colorPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            topConstraint,
            bottomConstraint,
            leadConstraint,
            trailConstraint
        ])
        
        
        colorPickerView.addTarget(self, action: #selector(colorChange), for: .valueChanged)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @objc func colorChange(_ sender:HRColorPickerView){
        var rValue:CGFloat = 0.0;
        var gValue:CGFloat = 0.0;
        var bValue:CGFloat = 0.0;
        var aValue:CGFloat = 0.0;
        sender.color.getRed(&rValue, green: &gValue, blue: &bValue, alpha: &aValue)
        let r = Int(rValue*255)
        let g = Int(gValue*255)
        let b = Int(bValue*255)
        
        print("r=\(r),g=\(g),b=\(b)");
        rgbRef.setValue([
            "R":r,
            "G":g,
            "B":b
        ])
        
    }
}

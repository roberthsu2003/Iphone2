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
        colorPickerView.translatesAutoresizingMaskIntoConstraints = false;
        let colorPickerViewConstraints = [
        colorPickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        colorPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        colorPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        colorPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(colorPickerViewConstraints)
        
        self.view.addSubview(colorPickerView)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    

}

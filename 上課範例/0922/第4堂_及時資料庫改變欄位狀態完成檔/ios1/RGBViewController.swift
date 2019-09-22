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
        self.view.addSubview(colorPickerView)
        colorPickerView.color = UIColor.green;
        colorPickerView.translatesAutoresizingMaskIntoConstraints = false;
        let colorPickerViewConstraints = [
        colorPickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
        colorPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        colorPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        colorPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(colorPickerViewConstraints)
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    

}

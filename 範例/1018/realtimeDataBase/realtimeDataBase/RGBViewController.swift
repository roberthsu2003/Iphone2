//
//  RGBViewController.swift
//  realtimeDataBase
//
//  Created by 徐國堂 on 2019/10/18.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Color_Picker_for_iOS

class RGBViewController: UIViewController {
    var colorPickerView = HRColorPickerView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView.color = UIColor.blue;
        self.view.addSubview(colorPickerView)
        /*
        colorPickerView.frame = view.frame;
        colorPickerView.frame.origin.y = 20;
 */
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

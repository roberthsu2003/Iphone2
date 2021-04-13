//
//  ColorViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/13.
//

import UIKit
import FlexColorPicker

class ColorViewController: UIViewController {
    let defaultColorPickerViewController = DefaultColorPickerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.pushViewController(defaultColorPickerViewController, animated: false)
    }
    

   
}

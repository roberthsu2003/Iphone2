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
        defaultColorPickerViewController.delegate = self;
        self.navigationController?.pushViewController(defaultColorPickerViewController, animated: false)
        
    }
}

extension ColorViewController: ColorPickerDelegate {

    func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
        //print(selectedColor)
    }
    
    func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
        // code to handle that user has confirmed selected color
        let red = confirmedColor.ciColor.red
        let green = confirmedColor.ciColor.green
        let blue = confirmedColor.ciColor.blue
        print("red=\(red)")
        print("green=\(green)")
        print("blue=\(blue)")
    }
}

//
//  ColorViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/13.
//

import UIKit
import FlexColorPicker
import Firebase

class ColorViewController: UIViewController {
    let defaultColorPickerViewController = DefaultColorPickerViewController()
    let rgbRef = Database.database().reference(withPath: "RGB")

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultColorPickerViewController.delegate = self;
        self.navigationController?.pushViewController(defaultColorPickerViewController, animated: false)
        /* firebase 更新就會執行
        rgbRef.observe(.value) { (snapshot:DataSnapshot) in
            guard let values = snapshot.value as? [String:Int] else{
                print("取值失敗")
                return
            }
            print("R=\(values["R"] ?? 0)")
            print("G=\(values["G"] ?? 0)")
            print("B=\(values["B"] ?? 0)")
            
        }
 */
        rgbRef.observeSingleEvent(of: .value) { (snapshot:DataSnapshot) in
            guard let values = snapshot.value as? [String:Int] else{
                print("取值失敗")
                return
            }
            print("R=\(values["R"] ?? 0)")
            print("G=\(values["G"] ?? 0)")
            print("B=\(values["B"] ?? 0)")
            let r = values["R"] ?? 0
            let g = values["G"] ?? 0
            let b = values["B"] ?? 0
            self.defaultColorPickerViewController.selectedColor = UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
        }
        
        
    }
}

extension ColorViewController: ColorPickerDelegate {

    func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
        //print(selectedColor)
    }
    
    func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
        // code to handle that user has confirmed selected color
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        confirmedColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        print("red:\(red)")
        print("green:\(green)")
        print("blue:\(blue)")
        print("alpha:\(alpha)")
    }
}

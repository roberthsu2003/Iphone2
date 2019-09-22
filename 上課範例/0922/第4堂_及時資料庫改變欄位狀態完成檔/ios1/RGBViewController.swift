//
//  RGBViewController.swift
//  
//
//  Created by Robert on 2019/9/22.
//

import UIKit
import Color_Picker_for_iOS
import Firebase

class RGBViewController: UIViewController {
    var colorPickerView = HRColorPickerView();
    var RGBRef = Database.database().reference(withPath: "RGB")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(colorPickerView)
        
        colorPickerView.translatesAutoresizingMaskIntoConstraints = false;
        let colorPickerViewConstraints = [
        colorPickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
        colorPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        colorPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        colorPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(colorPickerViewConstraints)
        //取得Firebase RGB節點內的資料(只有一次)
        
        RGBRef.observeSingleEvent(of: .value) { (snapshot:DataSnapshot) in
            if let colorValue = snapshot.value as? [String:CGFloat]{
                let r = colorValue["R"]! / 255;
                let g = colorValue["G"]! / 255;
                let b = colorValue["B"]! / 255;
                self.colorPickerView.color  = UIColor(red:r , green: g, blue: b, alpha: 1)
            }
        }
        
        //加入target Action
        colorPickerView.addTarget(self, action: #selector(colorChange), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func colorChange(_ sender:HRColorPickerView){
        let pickerColor = sender.color;
        var rValue = CGFloat()
        var gValue = CGFloat()
        var bValue = CGFloat();
        var alphaValue = CGFloat();
        pickerColor?.getRed(&rValue, green: &gValue, blue: &bValue, alpha: &alphaValue)
        print("r=\(rValue),g=\(gValue), b=\(bValue), alpha=\(alphaValue)");
        
        RGBRef.setValue([
            "R":Int(rValue * 255),
            "G":Int(gValue * 255),
            "B":Int(bValue * 255)
        ]) {
            (error:Error?, dbReference:DatabaseReference) in
            if error == nil{
                print("更新成功");
            }
        }
    }
    

}

//
//  ViewController.swift
//  faceDetect
//
//  Created by 徐國堂 on 2019/11/22.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var photoImageView:UIImageView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        let eyeView = UIView()
        eyeView.frame = CGRect(x: 0, y: 100, width: 100, height: 50)
        eyeView.backgroundColor = UIColor.clear
        eyeView.layer.borderColor = UIColor.red.cgColor
        eyeView.layer.borderWidth = 2
        photoImageView.addSubview(eyeView)
    }


}


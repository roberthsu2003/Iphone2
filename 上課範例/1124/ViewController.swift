//
//  ViewController.swift
//  faceDetect1
//
//  Created by 徐國堂 on 2019/11/24.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let faceView = UIView()
        faceView.frame = CGRect(x: 0, y: 100, width: 50, height: 50)
        faceView.backgroundColor = UIColor.red
        faceView.layer.borderWidth = 2
        faceView.layer.borderColor = UIColor.red.cgColor
        faceView.layer.backgroundColor = UIColor.clear.cgColor
        view.addSubview(faceView)
       
    }


}


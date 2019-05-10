//
//  ViewController.swift
//  parseJson
//
//  Created by Robert on 2019/5/10.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let json = "https://iostest-64ed7.firebaseapp.com/gjun.json"
    var urlSession:URLSession!;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        urlSession = URLSession.shared;
    }
    override func awakeFromNib() {
        super.awakeFromNib();
        print("awakeFromNib");
        print(urlSession.description)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }


}


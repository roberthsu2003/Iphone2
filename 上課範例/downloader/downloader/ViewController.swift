//
//  ViewController.swift
//  downloader
//
//  Created by 徐國堂 on 2021/4/6.
//

import UIKit

class ViewController: UIViewController {
    
    let downloader:Downloader = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = true
        config.allowsExpensiveNetworkAccess = true
        return Downloader(config: config)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doDownLoad(_ sender:UIButton){
        let paths = [ "https://flask-robert.herokuapp.com/static/cityImage/Auckland.jpg",
            "https://flask-robert.herokuapp.com/static/cityImage/Berlin.jpg",
            "https://flask-robert.herokuapp.com/static/cityImage/Birmingham.jpg"
        ]
    }


}


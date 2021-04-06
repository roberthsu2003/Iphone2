//
//  DownloadViewController.swift
//  downloadImage
//
//  Created by 徐國堂 on 2021/4/6.
//

import UIKit

class DownloadViewController: UIViewController {
    @IBOutlet var cityImageView:UIImageView!
    @IBOutlet var progressView:UIProgressView!
    let pathString = "https://flask-robert.herokuapp.com/static/cityImage/Akihabara.jpg"
    lazy var session:URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = true
        config.allowsExpensiveNetworkAccess = true
        let session = URLSession(configuration: config)
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func doElaborateHTTP(_ sender:UIButton){
        
    }

}

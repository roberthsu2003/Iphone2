//
//  ViewController.swift
//  downloader
//
//  Created by 徐國堂 on 2021/4/6.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cityImageView1:UIImageView!
    @IBOutlet var cityImageView2:UIImageView!
    @IBOutlet var cityImageView3:UIImageView!
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
    
    @IBAction func doDownLoad(_ sender:UIBarButtonItem){
        self.cityImageView1.image = nil
        self.cityImageView2.image = nil
        self.cityImageView3.image = nil
        let paths = [ "https://flask-robert.herokuapp.com/static/cityImage/Auckland.jpg",
            "https://flask-robert.herokuapp.com/static/cityImage/Berlin.jpg",
            "https://flask-robert.herokuapp.com/static/cityImage/Birmingham.jpg"
        ]
        let cityImageViews = [cityImageView1,cityImageView2,cityImageView3]
        for (index,path) in paths.enumerated(){
            let url = URL(string: path)!
            self.downloader.download(url: url) { (url:URL?) in
                if let url1 = url, let d = try? Data(contentsOf: url1){
                    let image = UIImage(data: d)
                    cityImageViews[index]?.image = image
                }
            }
        }
    }


}


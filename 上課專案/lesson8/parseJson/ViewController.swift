//
//  ViewController.swift
//  parseJson
//
//  Created by Robert on 2019/5/10.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let jsonURI = "https://iostest-64ed7.firebaseapp.com/gjun.json"
    var urlSession:URLSession!;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        urlSession = URLSession.shared;
        guard let jsonURL = URL(string: jsonURI) else{
            //false區塊
            print("url有問題")
            return;
        }
        
        let downloadTask = urlSession.downloadTask(with: jsonURL, completionHandler: {
            (url:URL?, response:URLResponse?, error:Error?) in
            
        })
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


//
//  ViewController.swift
//  json
//
//  Created by Robert on 2019/10/6.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var urlSession:URLSession!;

    override func viewDidLoad() {
        super.viewDidLoad()
        //建立連線
        urlSession = URLSession.shared
        guard let url = URL(string: "https://iostest-64ed7.firebaseapp.com/gjun.json") else{
            print("url有問題");
            return
        }
        
       let downloadTask = urlSession.downloadTask(with: url) { (url:URL?, response:URLResponse?, error:Error?) in
            guard let url = url, let response = response else{
                print("下載有問題1");
                return;
            }
            
            guard error == nil else{
                print("下載有問題2");
                return
            }
            
            guard (response as! HTTPURLResponse).statusCode == 200 else{
                print("下載有問題3");
                return;
            }
            
            guard let data = try? Data.init(contentsOf: url) else{
                print("下載有問題4");
                return;
            }
            
            print(String.init(data: data, encoding: String.Encoding.utf8)!)
            
        }
        
        downloadTask.resume();
        
        
        
        
    }


}


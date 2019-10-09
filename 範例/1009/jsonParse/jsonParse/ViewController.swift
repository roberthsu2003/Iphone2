//
//  ViewController.swift
//  jsonParse
//
//  Created by 徐國堂 on 2019/10/9.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let urlPath = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=a880adf3-d574-430a-8e29-3192a41897a5"
    var urlSession:URLSession!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //建立下載任務
        urlSession = URLSession.shared;
        guard let url = URL(string: urlPath) else{
            print("url有問題");
            return;
        }
        
        let downloadTask = urlSession.downloadTask(with: url){
        (url:URL?,response:URLResponse?,error:Error?) -> Void in
            guard url != nil, response != nil else{
                print("url或response是nil");
                return;
            }
        
            guard error == nil else{
                print("有錯誤發生:\(error!.localizedDescription)");
                return;
            }
        
            guard (response as! HTTPURLResponse).statusCode == 200 else{
                print("statusCode不是200");
                return
            }
        
            guard let data = try? (Data.init(contentsOf: url!)) else{
                print("data是nil");
                return
            }
            
            
            
            DispatchQueue.main.sync {
                print(String.init(data: data, encoding: String.Encoding.utf8)!);
            }
        
        }
        downloadTask.resume();
 
    }


}


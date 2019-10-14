//
//  ViewController.swift
//  jsonParse
//
//  Created by 徐國堂 on 2019/10/9.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

struct AllStation:Codable{
    struct Station:Codable{
        let region:String
        let name:String
        let tel:String
        let add:String
        let lat:Double
        let long:Double
    }
    let allStations:[Station]
}

class ViewController: UIViewController {
    let urlPath = "https://iostest-64ed7.web.app/gjun.json"
    var urlSession:URLSession!;
    var allStations = [AllStation.Station]();
    
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
                //print(String.init(data: data, encoding: String.Encoding.utf8)!);
                //使用JSON的decoder
                
                let jsonDecoder = JSONDecoder()
                guard var allStation = try? jsonDecoder.decode(AllStation.self, from: data) else{
                    print("轉換編碼失敗");
                    return
                }
                
                for station in allStation.allStations{
                    print(station.name)
                }
                
                self.allStations = allStation.allStations;
            }
        
        }
        downloadTask.resume();
 
    }


}


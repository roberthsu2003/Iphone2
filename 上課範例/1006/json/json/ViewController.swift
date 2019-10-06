//
//  ViewController.swift
//  json
//
//  Created by Robert on 2019/10/6.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit

struct AllStation:Codable{
    struct Station:Codable{
        let region:String;
        let name:String;
        let tel:String;
        let add:String;
        let lat:Double;
        let long:Double;
    }
    
    let allStations:[Station]
}

class ViewController: UICollectionViewController {
    var urlSession:URLSession!;
    var allStation:AllStation!;
    
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
            let jsonDecoder = JSONDecoder();
            self.allStation = try? jsonDecoder.decode(AllStation.self, from: data)
        
            if self.allStation != nil{
                print(self.allStation.allStations)
            }
        
            DispatchQueue.main.sync {
                //跳回主執行緒
                self.collectionView.reloadData();
            }
            
        }
        
        downloadTask.resume();
        
        
        
        
    }


}


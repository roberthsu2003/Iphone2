//
//  ViewController.swift
//  parseJson
//
//  Created by Robert on 2019/5/10.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
struct AllStation:Codable{
    let allStations:[Station];
    struct Station:Codable{
        let region:String;
        let name:String;
        let tel:String;
        let add:String;
        let lat:Double;
        let long:Double;
    }
    
}

class ViewController: UICollectionViewController {
    let jsonURI = "https://iostest-64ed7.firebaseapp.com/gjun.json"
    var urlSession:URLSession!;
    var allStations:AllStation!;
    let allStationsPath = \ViewController.allStations.allStations
    var myStations = [AllStation.Station]()
    
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
            
            guard let url = url, error == nil else{
                print("url和error出錯");
                return
            }
            
            guard let response = response,(response as! HTTPURLResponse).statusCode == 200 else{
                print("respone出錯");
                return
            }
            
            guard let jsonData = try? Data(contentsOf: url) else{
                print("Data出問題");
                return
            }
            
            DispatchQueue.main.sync {
                //print(String(data: jsonData, encoding: String.Encoding.utf8)!)
                let jsonDecoder = JSONDecoder();
                guard let allStation = try? jsonDecoder.decode(AllStation.self, from: jsonData) else{
                    print("解析出錯");
                    return;
                }
                self.allStations = allStation
                //self.myStations = self[keyPath:\ViewController.allStations.allStations]
                self.myStations = self.allStations.allStations
                print(self.myStations);
            }
            
            
        })
        
        downloadTask.resume();
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

extension ViewController{
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
    }
}


//
//  ViewController.swift
//  json
//
//  Created by Robert on 2019/10/6.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit
import MapKit

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
        
        
        let collectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout;
        collectionViewFlowLayout.itemSize = self.view.bounds.size;   
        
    }


}

extension ViewController{
    //UICollectionViewDataSourec
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if allStation == nil{
            return 0;
        }else{
            return allStation.allStations.count;
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let station = allStation.allStations[indexPath.item];
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! CustomCell;
        cell.addLabel?.text = "地址:\(station.add)"
        cell.nameLabel?.text = "分校名:\(station.name)"
        cell.regionLabel?.text = "地區:\(station.region)"
        cell.telLabel?.text = "電話:\(station.tel)"
        
        let annotation = MKPointAnnotation();
        let coordinate = CLLocationCoordinate2D(latitude: station.lat, longitude: station.long)
        annotation.coordinate = coordinate;
        cell.mapView.addAnnotation(annotation);
        //let span = MKCoordinateSpan(latitudeDelta: 250, longitudeDelta: 250)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 250, longitudinalMeters: 250);
        
        cell.mapView.setRegion(region, animated: false);
        
        return cell;
        
    }
}


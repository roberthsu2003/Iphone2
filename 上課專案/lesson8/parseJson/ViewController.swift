//
//  ViewController.swift
//  parseJson
//
//  Created by Robert on 2019/5/10.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import MapKit

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
    //var myStations:[AllStation.Station]!;
    
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
                self.collectionView.reloadData();
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
        return myStations.count;
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! CustomCell
        let station = myStations[indexPath.row]
        cell.regionLabel.text = "縣市:\(station.region)"
        cell.nameLabel.text = "分校名:\(station.name)"
        cell.addLabel.text = "地址:\(station.add)"
        cell.telLabel.text = "電話:\(station.tel)"
        
        let mapView:MKMapView = cell.mapView
        let annotion = MKPointAnnotation();
        let coordinate = CLLocationCoordinate2D(latitude: station.lat, longitude: station.long)
        annotion.coordinate = coordinate;
        mapView.addAnnotation(annotion);
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
        mapView.setRegion(region, animated: false)
        return cell;
    }
}


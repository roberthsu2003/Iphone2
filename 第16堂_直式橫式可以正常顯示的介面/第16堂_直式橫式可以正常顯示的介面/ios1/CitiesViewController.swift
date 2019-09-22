//
//  CitiesViewController.swift
//  ios1
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Firebase



class CitiesViewController: UICollectionViewController {
    var cities:[City] = [];
    var citeRef:DatabaseReference!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citeRef = Database.database().reference(withPath: "n135/cities");
        citeRef.observeSingleEvent(of: .value){
            (dataSnapshot:DataSnapshot) -> Void in
            
            let allChildrens = dataSnapshot.children.allObjects as! [DataSnapshot];
            print(allChildrens);
            for itemSnapshot in allChildrens{
                let city = City();
               city.childId = itemSnapshot.key
                let cityData = itemSnapshot.value as! [String:String];
                city.city = cityData["City"]!;
                city.continent = cityData["Continent"]!;
                city.country = cityData["Country"]!;
                city.imageName = cityData["Image"]!;
                city.local = cityData["Local"]!;
                city.region = cityData["Region"]!;
                self.cities.append(city);
            }
            self.collectionView?.reloadData();
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail"{
            let detailViewController = segue.destination as! DetailViewController;
            let indexPath = sender as! IndexPath;
            detailViewController.city = cities[indexPath.item];
        }
    }

    

}

extension CitiesViewController{
    //UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return cities.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! CustomCell;
        let city = cities[indexPath.item];
        cell.cityLabel.text = city.city;
        if city.image == nil{
            let imageName = city.imageName;
            let imageRef = Storage.storage().reference(withPath: "n135/images/\(imageName)");
            imageRef.getData(maxSize: 1*1024*1024){
                (data:Data?,error:Error?) -> Void in
                if let data = data, error == nil {
                    city.image  = UIImage(data: data);
                }
                
                cell.imageView.image = city.image;
                //collectionView.reloadData();
            }
            
        }else{
           cell.imageView.image = city.image;
        }
        
       
        
        return cell;
        
    }
}

extension CitiesViewController{
    //UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if cities.count > 0{
            performSegue(withIdentifier: "goDetail", sender: indexPath);
        }
    }
}

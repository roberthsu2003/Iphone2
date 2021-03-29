//
//  DetailViewController.swift
//  lesson3_1
//
//  Created by 徐國堂 on 2021/3/25.
//

import UIKit



struct AllData:Codable {
    struct Region1:Codable {
        let ar:String
        let bemp:Int
        let lat:Double
        let lng:Double
        let mday:String
        let sbi:Int
        let sna:String
        let tot:Int
    }
    
    let data:[Region1]
    
}

class DetailViewController: UITableViewController {
    var regionName:String!
    var allRegion:AllData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlComponets = URLComponents()
        urlComponets.scheme = "https"
        urlComponets.host = "flask-robert.herokuapp.com"
        urlComponets.path = "/youbike/" + regionName
        guard let url = urlComponets.url else{
            print("url編碼錯誤")
            return
        }
        
        let downloadTask = URLSession.shared.downloadTask(with: url){
            (saveURL:URL?, response:URLResponse?, error:Error?) in
            guard let saveURL=saveURL, let response = response, error == nil else{
                print("下載失敗")
                return
            }
            
            guard (response as! HTTPURLResponse).statusCode == 200 else{
                print("狀態不是200")
                return
            }
            
            guard let data = try? Data(contentsOf: saveURL) else{
                print("下載資料無法轉出")
                return
            }
            
            //print(String(data: data, encoding: .utf8)!)
            
            let jsonDecoder = JSONDecoder()
            guard let allData = try? jsonDecoder.decode(AllData.self, from: data) else{
                print("json無法轉換")
                return
            }
            self.allRegion = allData
            print(self.allRegion!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
           }
                
                
               
            }
        
    
        downloadTask.resume()
    }
        
        
        
        

    // MARK: - Table view data source


override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let region = allRegion{
        return region.data.count
    }else{
        return 0
    }
}


override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
       let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
       
       // Configure the cell’s contents.
        cell.textLabel!.text = allRegion.data[indexPath.row].sna
           
       return cell
    }
}

    
    

    



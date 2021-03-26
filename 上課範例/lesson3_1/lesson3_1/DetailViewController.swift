//
//  DetailViewController.swift
//  lesson3_1
//
//  Created by 徐國堂 on 2021/3/25.
//

import UIKit

class DetailViewController: UITableViewController {
    var regionName:String!
    var baseURLString = "https://flask-robert.herokuapp.com"
    
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
            
            DispatchQueue.main.async {
                print(String(data: data, encoding: .utf8))
           }
                
                
               
            }
        
    
        downloadTask.resume()
    }
        
        
        
        

    // MARK: - Table view data source

override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
   

    
    

    



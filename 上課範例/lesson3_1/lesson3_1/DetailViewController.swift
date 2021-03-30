//
//  DetailViewController.swift
//  lesson3_1
//
//  Created by 徐國堂 on 2021/3/25.
//

import UIKit

class DetailViewController: UITableViewController {
    var regionName:String!
    var urlSession:URLSession!
    
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
        print(url.absoluteString)
        let config = URLSessionConfiguration.ephemeral
        config.allowsExpensiveNetworkAccess = true
        self.urlSession = URLSession(configuration: config, delegate: self, delegateQueue: .main)
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

extension DetailViewController:URLSessionDelegate{
    
}
   

    
    

    



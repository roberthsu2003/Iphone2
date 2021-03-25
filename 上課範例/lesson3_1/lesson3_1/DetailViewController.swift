//
//  DetailViewController.swift
//  lesson3_1
//
//  Created by 徐國堂 on 2021/3/25.
//

import UIKit

class DetailViewController: UITableViewController {
    var regionName:String!
    var baseURLString = "https://flask-robert.herokuapp.com/youbike/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseURLString = baseURLString + "a"
        print(baseURLString)
        var detailUrl = URL(string: baseURLString)
        print(detailUrl)
        
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

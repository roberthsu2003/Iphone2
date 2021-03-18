//
//  ViewController.swift
//  lesson1_1
//
//  Created by 徐國堂 on 2021/3/16.
//

import UIKit

class ViewController: UITableViewController {
    var states:[String:[String]]!
    var names:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let targetPath = Bundle.main.path(forResource: "statedictionary", ofType: "plist"){
            
            if let states = NSDictionary(contentsOfFile: targetPath) as? [String:[String]]{
                self.states = states
                self.names = [String](states.keys)
            }
            
        }
        
        
        //tableView.dataSource = self;
        
        
    }


}

extension ViewController{
    //UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return self.names.count
    }
    
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int{
        //透過names取出州名稱
        let stateName = names[section]
        //透過州名稱取出該州所有的區號
        let postNums = states[stateName]!
        return postNums.count
    }
    
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let section = indexPath.section
        let row = indexPath.row
        //透過names取出州名稱
        let stateName = names[section]
        //透過州名稱取出該州所有的區號(Array)
        let postNums = states[stateName]!
        let postNum = postNums[row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel!.text = postNum
        return cell;
    }
    
    override func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String?{
        return names[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]?{
        return names
    }
}


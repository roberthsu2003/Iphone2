//
//  ViewController.swift
//  lesson1
//
//  Created by Robert on 2019/4/8.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    @IBOutlet var tableView:UITableView!
    var states = [String:[String]]()
    var stateNames = [String]();
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //初始化statedictionary.plish
        /*
        if let path = Bundle.main.path(forResource: "statedictionary", ofType: "plist"){
            print(path);
        }else{
            print("檔案有問題");
        }
 */
        let path = Bundle.main.path(forResource: "statedictionary", ofType: "plist")!
        /*
        let myState = NSDictionary(contentsOfFile: path);
        states = myState as! [String:[String]]
 */
        states = NSDictionary(contentsOfFile: path) as! [String:[String]]
        //print(states)
        //print(states.keys)
        stateNames = [String](states.keys).sorted()
        print(stateNames)
        for name in stateNames{
            print("\(name)州")
            print("================");
            let postNums = states[name]!
            for postNum in postNums{
                print(postNum)
            }
            print("================");
        }
       
        
        
        
        
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        tableView.dataSource = self
    }
    
    
    //UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int{
        return stateNames.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let stateName = stateNames[section];
        let postNums = states[stateName]!;
        return postNums.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let section = indexPath.section
        let row = indexPath.row
        let stateName = stateNames[section]
        let postNums = states[stateName]!
        let postNumber = postNums[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel!.text = postNumber;
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return stateNames[section]
    }

}


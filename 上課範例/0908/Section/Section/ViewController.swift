//
//  ViewController.swift
//  Section
//
//  Created by Robert on 2019/9/8.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView:UITableView!
    var states = DataSource.states;
    lazy var nameOfStates = [String](states.keys).sorted()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(nameOfStates[0])
    }


}

extension ViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int{
        return nameOfStates.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let name = nameOfStates[section];
        let postNums = states[name]!;
        return postNums.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //取得Cell要顯示的資料
        let sectionIndex = indexPath.section;
        let rowIndex = indexPath.row;
        let name = nameOfStates[sectionIndex];
        let postNums = states[name]
        let postNum = postNums![rowIndex]
        
        //取得Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath);
        cell.textLabel?.text = postNum;
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return nameOfStates[section];
    }
}

extension ViewController:UITableViewDelegate{
    func sectionIndexTitles(for tableView: UITableView) -> [String]?{
        let fourWordName:[String] = nameOfStates.map({
            (stateName:String) -> String in
            let index = stateName.index(stateName.startIndex, offsetBy: 4);
            let newStr = String(stateName[..<index])
            return newStr
        });
        return fourWordName;
    }
}


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
        /*
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documents = paths.last!
        print(documents)
        */
        let fileManager = FileManager.default
        let documentsUrl = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        print(documentsUrl.path)
        let plistInDocumentsUrl = documentsUrl.appendingPathComponent("statedictionary.plist")
        print(plistInDocumentsUrl.path)
        /*
        if let targetPath = Bundle.main.path(forResource: "statedictionary", ofType: "plist"){
            
            if let states = NSDictionary(contentsOfFile: targetPath) as? [String:[String]]{
                self.states = states
                self.names = [String](states.keys)
            }
            
        }
         */
        
        guard let targetURL = Bundle.main.url(forResource: "statedictionary", withExtension: "plist") else {
            print("沒有這個檔案")
            return
        }
        if let states = NSDictionary(contentsOf: targetURL) as? [String:[String]]{
            self.states = states
            self.names = [String](states.keys)
        }
        
        //plist copy到sandbox模型
        if !FileManager.default.fileExists(atPath: plistInDocumentsUrl.path){
            if (try? FileManager.default.moveItem(at: targetURL, to: plistInDocumentsUrl)) == nil{
                print("copy失敗")
            }else{
                print("copy成功")
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


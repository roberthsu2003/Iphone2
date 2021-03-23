//
//  DataSource.swift
//  lesson2_1
//
//  Created by 徐國堂 on 2021/3/18.
//

import Foundation

struct Region:Codable{
    let areas:[String]
}
class DataSource{
    static let areasHttpString = "https://flask-robert.herokuapp.com/youbike/"
    static var main:DataSource = { //只會執行一次
        //建立額外的動作
        let dataSource = DataSource()
        let url = URL(string: areasHttpString)!
        print("下載")
        let downloadTask = URLSession.shared.downloadTask(with: url) { (saveURL:URL?, response:URLResponse?, error:Error?) in
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
            
            //print(String.init(data: data, encoding: .utf8))
            
            let jsonDecoder = JSONDecoder()
            guard let region = try? jsonDecoder.decode(Region.self, from: data) else{
                print("jsonDecoder無法轉換")
                return
            }
            
            print("region數量:\(region.areas.count)")
            for item in region.areas{
                print(item)
            }
            
        }
        downloadTask.resume()
        
        return dataSource
    }()
}

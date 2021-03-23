//
//  DataSource.swift
//  lesson2_1
//
//  Created by 徐國堂 on 2021/3/18.
//

import Foundation
class DataSource{
    static let areasHttpString = "https://flask-robert.herokuapp.com/youbike/"
    static var main:DataSource = { //只會執行一次
        //建立額外的動作
        let dataSource = DataSource()
        let url = URL(string: areasHttpString)!
        print("下載")
        let downloadTask = URLSession.shared.downloadTask(with: url) { (saveURL:URL?, response:URLResponse?, error:Error?) in
            if let saveURL=saveURL, let response = response, error == nil{
                print("下載成功")
            }else{
                print("下載失敗")
            }
        }
        downloadTask.resume()
        
        return dataSource
    }()
}

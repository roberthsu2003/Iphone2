//
//  ViewController.swift
//  lesson3_1
//
//  Created by 徐國堂 on 2021/3/23.
//

import UIKit

struct Region:Codable{
    let areas:[String]
}

class ViewController: UIViewController {
    let areasHttpString = "https://flask-robert.herokuapp.com/youbike/"
    //var areas:[String]!
    var areas = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: areasHttpString)!
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
                let jsonDecoder = JSONDecoder()
                guard let region = try? jsonDecoder.decode(Region.self, from: data) else{
                    print("jsonDecoder無法轉換")
                    return
                }
                print("下載成功")
                
                self.areas = region.areas
                print(self.areas)
            }
        }
        downloadTask.resume()
    }


}


//
//  ViewController.swift
//  lesson2_1
//
//  Created by 徐國堂 on 2021/3/18.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DataSource.main.getDownloadData = {(donwloadRegion:Region) in
            print("region數量:\(donwloadRegion.areas.count)")
            for item in donwloadRegion.areas{
                print(item)
            }
        }
        print("viewDidLoad")
    }


}


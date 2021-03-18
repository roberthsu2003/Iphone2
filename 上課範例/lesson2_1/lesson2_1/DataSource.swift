//
//  DataSource.swift
//  lesson2_1
//
//  Created by 徐國堂 on 2021/3/18.
//

import Foundation
class DataSource{
    var property1 = 15
    var property2 = 30
    var property3 = 45
    static var main:DataSource = {
        //建立額外的動作
        let dataSource = DataSource()
        return dataSource
    }()
}

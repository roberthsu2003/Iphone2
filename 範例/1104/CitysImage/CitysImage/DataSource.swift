//
//  DataSource.swift
//  CitysImage
//
//  Created by 徐國堂 on 2019/11/4.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import Foundation
class DataSource{
    static var dataSource:DataSource = {
        print("執行");
        return DataSource();
    }()
    
    private init(){
        checkDataInFirestore()
    }
    
    func checkDataInFirestore(){
        
    }
}

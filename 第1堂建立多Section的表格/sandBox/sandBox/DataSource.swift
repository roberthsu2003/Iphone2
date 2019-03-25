//
//  DataSource.swift
//  sandBox
//
//  Created by n135 on 2018/1/28.
//  Copyright © 2018年 n135. All rights reserved.
//

import Foundation
class DataSource{
    private init(){
        
    }
    static var states:[String:[String]] = {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        let documentPath = paths.last!;
        let targetPath = "\(documentPath)/state.plist";
        print(targetPath);
        if !FileManager.default.fileExists(atPath: targetPath) {
            //只會執行一次
            let sourcePath = Bundle.main.path(forResource: "statedictionary", ofType: "plist");
            try! FileManager.default.moveItem(atPath: sourcePath!, toPath: targetPath);
        }
        if let states = NSDictionary(contentsOfFile: targetPath) as? [String:[String]]{
            return states
        }
        return [String:[String]]();
    }();
}



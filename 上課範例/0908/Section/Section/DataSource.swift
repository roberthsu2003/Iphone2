//
//  DataSource.swift
//  Section
//
//  Created by Robert on 2019/9/8.
//  Copyright © 2019 ios1. All rights reserved.
//

import Foundation
class DataSource{
    
    static var states:[String:[String]] = {
        let sourcePath = Bundle.main.path(forResource: "statedictionary", ofType: "plist")!;
        /*
        if let states = NSDictionary(contentsOfFile: sourcePath) as? [String:[String]]{
            return states;
        }
        return [String:[String]]();
 */
        return NSDictionary(contentsOfFile: sourcePath) as? [String:[String]] ?? [String:[String]]()
    }()
    
    private init(){
        
    }

}

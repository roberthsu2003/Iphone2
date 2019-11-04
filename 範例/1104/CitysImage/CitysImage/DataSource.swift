//
//  DataSource.swift
//  CitysImage
//
//  Created by 徐國堂 on 2019/11/4.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import Foundation
import Firebase

class DataSource{
    var firestore = Firestore.firestore()
    var createUpLoadButton:(() -> Void)!
    
    static var dataSource:DataSource = {
        print("執行");
        return DataSource();
    }()
    
    private init(){
        checkDataInFirestore()
    }
    
    func checkDataInFirestore(){
        firestore.collection("citys").addSnapshotListener { (snapshot:QuerySnapshot?, error:Error?) in
            guard error == nil else{
                print("error:\(error!.localizedDescription)");
                return
            }
            
            guard let snapshot = snapshot else{
                print("snapshot是nil");
                return
            }
            
            if snapshot.isEmpty{
                
                print("snapshot是empty");
                if self.createUpLoadButton != nil {
                    self.createUpLoadButton();
                }
                
            }
            
            
        }
    }
}

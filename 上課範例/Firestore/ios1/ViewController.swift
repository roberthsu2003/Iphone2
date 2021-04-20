//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/15.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var firestore = Firestore.firestore()
    lazy var presidents:[[String:String]] = {
        let pathURL = Bundle.main.url(forResource: "PresidentList", withExtension: "plist")
        guard let rootDictionary = NSDictionary(contentsOf: pathURL!) as? [String:Any] else{
            return [[:]]
        }
        let presidents = rootDictionary["presidents"]
        return presidents as! [[String:String]]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil{
            print("登入完成")
            doAnotherThing()
        }else{
            Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                guard let _ = result, error == nil else{
                    print("登入錯誤")
                    return
                }
                self.doAnotherThing()
            }
        }
    }

    func doAnotherThing(){
        print("登入後要做事的地方")
        
    }
    
    @IBAction func uploadData(_ sender:UIBarButtonItem){
        let batch = firestore.batch()
        for president in presidents{
            let documentRef = firestore.collection("presidents").document()
            batch.setData(president, forDocument: documentRef)
        }
        
        batch.commit { (error:Error?) in
            if error == nil{
                print("batch成功")
            }else{
                print("batch失敗")
            }
        }
    }
}


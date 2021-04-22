//
//  DetailViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/22.
//

import UIKit
import WebKit
import Firebase

class DetailViewController: UIViewController {
    @IBOutlet var webView:WKWebView!
    var name:String!
    var firestore = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        firestore.collection("presidents").whereField("name", isEqualTo: name!).getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
            guard let snapshot = snapshot, error == nil else{
                print("取得資料錯誤")
                return
            }
            let documents = snapshot.documents
            guard let queryDocumentsnapshot = documents.first else{
                return
            }
            let president = queryDocumentsnapshot.data()
            guard let urlString = president["url"] as? String else{
                return
            }
            guard let url = URL(string: urlString) else{
                return
            }
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

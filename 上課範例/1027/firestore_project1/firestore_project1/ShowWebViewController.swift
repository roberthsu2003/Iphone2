//
//  ShowWebViewController.swift
//  firestore_project1
//
//  Created by 徐國堂 on 2019/10/27.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import WebKit

class ShowWebViewController: UIViewController {
    @IBOutlet var webView:WKWebView!;
    var webPath:String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let webURL = URL(string: webPath) else{
            print("url有錯誤");
            return
        }
        
        let webRequest = URLRequest(url: webURL);
        let _ = webView.load(webRequest)
        
        
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

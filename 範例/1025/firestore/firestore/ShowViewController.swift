//
//  ShowViewController.swift
//  firestore
//
//  Created by 徐國堂 on 2019/10/25.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import WebKit

class ShowViewController: UIViewController {
    var webPath:String!
    @IBOutlet var webView:WKWebView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: webPath ?? "") else{
            print("url有問題");
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
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

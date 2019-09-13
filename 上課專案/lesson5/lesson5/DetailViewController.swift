//
//  DetailViewController.swift
//  lesson5
//
//  Created by Robert on 2019/4/29.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var president:[String:String]!
    @IBOutlet var webView:WKWebView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = president["name"]!
        let url = URL(string: president["url"]!)!
        let req = URLRequest(url: url);
        webView.load(req);
        
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

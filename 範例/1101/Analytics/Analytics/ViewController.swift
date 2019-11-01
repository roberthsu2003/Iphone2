//
//  ViewController.swift
//  Analytics
//
//  Created by 徐國堂 on 2019/11/1.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ItemA"
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
        AnalyticsParameterItemID: "id-\(title!)",
        AnalyticsParameterItemName: title!,
        AnalyticsParameterContentType: "content"
        ])
    }


}


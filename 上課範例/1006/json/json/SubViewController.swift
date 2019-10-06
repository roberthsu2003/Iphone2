//
//  SubViewController.swift
//  json
//
//  Created by Robert on 2019/10/6.
//  Copyright © 2019 ios1. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    var pageViewController:UIPageViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.addChild(pageViewController);
        self.view.addSubview(pageViewController.view);
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let contentViewController = storyboard.instantiateViewController(identifier: "content");
        
        pageViewController.setViewControllers([contentViewController], direction: .forward, animated: false, completion: nil);
        
    }
    

   
}

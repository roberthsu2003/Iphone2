//
//  DHTViewController.swift
//  ios1
//
//  Created by Robert on 2019/9/22.
//  Copyright © 2019 Gjun. All rights reserved.
//

import UIKit

class DHTViewController: UITableViewController {
    @IBOutlet var textFields:[UITextField]!;
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false;
        tableView.bounces = false;
        for textField in textFields{
            textField.isEnabled = false;
            textField.text = "10.10c"
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

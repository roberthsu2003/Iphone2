//
//  DetailViewController.swift
//  ios1
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var city:City!;
    
    @IBOutlet weak var continentField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var cityNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continentField.text = city.continent;
        countryField.text = city.country;
        cityNameField.text = city.city;
        (tableView.tableHeaderView as! UIImageView).image = city.image;
        //print(city.image!);
    }

   

}

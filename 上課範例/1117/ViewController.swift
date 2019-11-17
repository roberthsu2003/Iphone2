//
//  ViewController.swift
//  textRecognizer1
//
//  Created by 徐國堂 on 2019/11/17.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var photoImageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectedImage(_ sender:UIBarButtonItem){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .photoLibrary
            present(imagePickerController, animated: true, completion: nil)
        }
    }
}

extension ViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        print("選擇圖片");
    }
}



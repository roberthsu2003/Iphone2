//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/5/6.
//

import UIKit
import MLKitTextRecognition

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func userSelectedImage(_ sender:UIBarButtonItem){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self;
            imagePicker.allowsEditing = false;
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func onDeviceTextRecognition(_ sender:UIButton){
        
    }
    
    @IBAction func onCloudTextRecognition(_ sender:UIButton){
        
    }


}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
}


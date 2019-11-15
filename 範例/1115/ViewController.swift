//
//  ViewController.swift
//  textRecognize
//
//  Created by 徐國堂 on 2019/11/13.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var photoImageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    @IBAction func onCloundTextRecognition(_ sender:UIButton){
        
    }


}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[.originalImage] as? UIImage else{
            print("取出照片出錯");
            return
        }
        
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
        
    }
}


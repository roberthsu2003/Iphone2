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
    @IBOutlet var messageOfTextRecognizer:UITextView!
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
    
    @IBAction func userOnDevice(_ sender:UIButton){
        
    }
    
    @IBAction func userOnCloud(_ sender:UIButton){
        
    }
}

extension ViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard  let selectedImage = info[.originalImage] as? UIImage else{
            print("選取的圖片失敗");
            return
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}



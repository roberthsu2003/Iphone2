//
//  ViewController.swift
//  faceDetect
//
//  Created by 徐國堂 on 2019/11/22.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var photoImageView:UIImageView!;
    @IBOutlet var messageTextView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let eyeView = UIView()
        eyeView.frame = CGRect(x: 0, y: 100, width: 100, height: 50)
        eyeView.backgroundColor = UIColor.clear
        eyeView.layer.borderColor = UIColor.red.cgColor
        eyeView.layer.borderWidth = 2
        photoImageView.addSubview(eyeView)
 */
    }
    
    @IBAction func userSelectedImage(_ sender:UIBarButtonItem){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self;
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil);
        }
    }


}

extension ViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
           if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
               photoImageView.image = selectedImage;
               photoImageView.clipsToBounds = true;
           }
           messageTextView.text = ""
           dismiss(animated: true, completion: nil);
           
       }
}


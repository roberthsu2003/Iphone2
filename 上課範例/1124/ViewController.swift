//
//  ViewController.swift
//  faceDetect1
//
//  Created by 徐國堂 on 2019/11/24.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var  photoImageView:UIImageView!
    @IBOutlet var messageTextView:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let faceView = FaceView()
        faceView.frame = CGRect(x: 0, y: 100, width: 50, height: 50)
        faceView.backgroundColor = UIColor.red
        faceView.layer.borderWidth = 2
        faceView.layer.borderColor = UIColor.red.cgColor
        faceView.layer.backgroundColor = UIColor.clear.cgColor
        view.addSubview(faceView)
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


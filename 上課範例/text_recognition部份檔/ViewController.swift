//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/5/6.
//

import UIKit
import MLKit

class ViewController: UIViewController {
    @IBOutlet var photoImageView:UIImageView!
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
        guard let originalImage = photoImageView.image else{
            print("沒有選取圖片")
            return
        }
        let visionImage = VisionImage(image: originalImage)
        let textRecognizer = TextRecognizer.textRecognizer()
        textRecognizer.process(visionImage) { (text:Text?, error:Error?) in
            guard error == nil,let result = text else{
                print("辦識有問題")
                return
            }
            print(result.text)
        }
        
    }
    
    @IBAction func onCloudTextRecognition(_ sender:UIButton){
        
    }


}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let original = info[.originalImage] as? UIImage{
            photoImageView.image = original;
            photoImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
}


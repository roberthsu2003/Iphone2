//
//  ViewController.swift
//  textRecognizer1
//
//  Created by 徐國堂 on 2019/11/17.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

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
        var messageText = "";
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        guard let originImage = photoImageView.image else{
            showMessage(message: "沒有選取圖片")
            return
        }
        let visionImage = VisionImage(image: originImage)
        textRecognizer.process(visionImage) { (vistionText:VisionText?, error:Error?) in
            guard let vistionText = vistionText, error == nil else{
                if let error = error{
                    self.showMessage(message: error.localizedDescription)
                }
                
                return
            }
            
            //巢狀function
            func recognizeCarNum(blockStirng:String) -> Int?{
                let endIndex = blockStirng.index(before: blockStirng.endIndex)
                let startIndex = blockStirng.index(blockStirng.endIndex, offsetBy: -4)
                let trackSubString = blockStirng[startIndex...endIndex]
                let trackString = String(trackSubString)
                if let carNumer = Int(trackString){
                    return carNumer
                }else{
                    return nil;
                }
                
            }
            
            for block in vistionText.blocks{
                
                let blockText = block.text
                switch (blockText.count){
                    case 6...8:
                        
                        if let _ = recognizeCarNum(blockStirng: blockText) {
                            messageText += "carNumber:\(blockText)\n"
                            
                            //print("carNumber:\(blockText)");
                        }else{
                            messageText += "\(blockText)這不是車牌\n"
                            //print("\(blockText)這不是車牌");
                        }
                        
                    default:
                        messageText += "\(blockText)這不是車牌\n"
                        break
                        //print("\(blockText)這不是車牌");
                }
            }
            self.messageOfTextRecognizer.text = messageText
           
        }
        
    }
    
    //ViewController的method
    func showMessage(message:String){
        let alertController = UIAlertController(title: "錯誤", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func userOnCloud(_ sender:UIButton){
        let vision = Vision.vision()
        let textRecognizer = vision.cloudTextRecognizer()
        guard let originImage = photoImageView.image else{
            showMessage(message: "沒有選取圖片")
            return
        }
        let visionImage = VisionImage(image: originImage)
        let option = VisionCloudTextRecognizerOptions();
        option.languageHints = ["en", "zh"]
        textRecognizer.process(visionImage) { (vistionText:VisionText?, error:Error?) in
            guard let vistionText = vistionText, error == nil else{
                self.showMessage(message: "辨識錯誤")
                return
            }
            
            self.messageOfTextRecognizer.text = vistionText.text
        }
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



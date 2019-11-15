//
//  ViewController.swift
//  textRecognize
//
//  Created by 徐國堂 on 2019/11/13.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var photoImageView:UIImageView!
    @IBOutlet var textMessage:UITextView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func userSelectedImage(_ sender:UIBarButtonItem){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false;
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func onDeviceTextRecognition(_ sender:UIButton){
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        guard let originImage = photoImageView.image else{
            print("圖片有問題")
            return
        }
         let visionImage = VisionImage(image: originImage)
        textRecognizer.process(visionImage) { (text:VisionText?, error:Error?) in
            guard let visionText = text, error == nil else{
                print("文字辦識出問題:\(error!.localizedDescription)");
                return
            }
            
            //print("visionText.text:\(visionText.text)")
            //print("visionText.blocks的數量:\(visionText.blocks.count)")
            func subtractTextAndValidate(source:String) -> Int?{
               
                let startIndex = source.index(source.endIndex, offsetBy: -4)
                let endIndex = source.index(before: source.endIndex)
                let numberString = source[startIndex...endIndex]
                print(numberString)
                guard let cardNum = Int(numberString) else{
                    return nil;
                }
                return cardNum;
            }
            
            for textBlock in visionText.blocks{
                let text = textBlock.text
                
                switch(text.count){
                
                case 6...8:
                    
                    if let carNumber = subtractTextAndValidate(source: text){
                        print(text, terminator:" :");
                        print("車牌號碼後4碼:\(carNumber)");
                        self.textMessage.text = "車牌是:\(text)"
                    }else{
                        print(text, terminator:" :");
                        print("不是車牌號碼)");
                    }
                    
                  
                    
                default:
                        
                        print(text, terminator:":");
                        print("不是車牌號碼")
                }

 
                
            }
            
            
            
            
        
      }
    }
    
    @IBAction func onCloundTextRecognition(_ sender:UIButton){
        let vision = Vision.vision()
        let options = VisionCloudTextRecognizerOptions()
        options.languageHints = ["en", "zh"]
        let textRecognizer = vision.cloudTextRecognizer(options: options)
        guard let originImage = photoImageView.image else{
            print("圖片出錯");
            return
        }
        let visionImage = VisionImage(image: originImage)
        textRecognizer.process(visionImage) { (visionText:VisionText?, error:Error?) in
            guard let visionText = visionText , error == nil else{
                print("辦試錯誤");
                return
            }
            
            let resultText = visionText.text;
            
            self.textMessage.text = resultText
        }
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


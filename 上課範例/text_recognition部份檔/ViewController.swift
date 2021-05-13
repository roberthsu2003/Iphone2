//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/5/6.
//

import UIKit
import MLKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var photoImageView:UIImageView!
    @IBOutlet var messageTextView:UITextView!
    lazy var functions = Functions.functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
            print("尚未登入")
            performSegue(withIdentifier: "goLogin", sender: nil)
        }else{
            print("已經登入")
            //performSegue(withIdentifier: "goLogin", sender: nil)
        }
        
        
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
            //print(result.text)
            self.messageTextView.text = ""
            for (index,block) in result.blocks.enumerated(){
                let blockText = block.text
                //print("block\(index):\(blockText)")
                self.messageTextView.text += "block\(index):\(blockText)\n"
            }
        }
        
    }
    
    @IBAction func onCloudTextRecognition(_ sender:UIButton){
        guard let uiImage = photoImageView.image else{
            print("請先選擇圖片")
            return
            
        }
        
        guard let imageData = uiImage.jpegData(compressionQuality: 1.0) else { return }
        
        let base64encodeImage = imageData.base64EncodedString()
        
        let requestData = [
          "image": ["content": base64encodeImage],
          "features": ["type": "TEXT_DETECTION"],
          "imageContext": ["languageHints": ["en"]]
        ]
        
        functions.httpsCallable("annotateImage").call(requestData){ (result:HTTPSCallableResult?, error:Error?) in
            if let error = error as NSError?{
                if error.domain == FunctionsErrorDomain{
                    print("有錯誤")
                    if let code = FunctionsErrorCode(rawValue: error.code){
                        print(code)
                        return
                        
                    }
                    let message = error.localizedDescription
                    print(message)
                    if let detail = error.userInfo[FunctionsErrorDetailsKey] {
                        print(detail)
                        return
                        
                    }
                    
                   
                   
                   
                    
                   
                }
                
                guard let annotation = (result?.data as? [String:Any])?["fullTextAnnotation"] as? [String:Any] else{
                    print("沒有解析")
                    return
                }
                
                print("解析完成")
                let text = annotation["text"] as? String ?? ""
                print(text)
            }
        }
        
        
        
    }
    
    @IBAction func loginGoBack(_ sender:UIStoryboardSegue){
        let loginViewController = sender.source as! LoginViewController
        print(loginViewController.math)
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


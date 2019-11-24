//
//  ViewController.swift
//  faceDetect1
//
//  Created by 徐國堂 on 2019/11/24.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var  photoImageView:UIImageView!
    @IBOutlet var messageTextView:UITextView!
    lazy var vision = Vision.vision()
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
    @IBAction func faceCount(_ sender:UIButton){
        let options = VisionFaceDetectorOptions();
        options.performanceMode = .accurate;
        let faceDetector = vision.faceDetector(options: options)
        guard let originalImage = photoImageView.image else{
            print("沒有選圖片");
            return;
        }
        
        let visionImage = VisionImage(image: originalImage)
        faceDetector.process(visionImage) { (faces:[VisionFace]?, error:Error?) in
            guard let visionFaces = faces, !visionFaces.isEmpty, error == nil else{
                if let description = error?.localizedDescription{
                    print("error:\(description)")
                }
                return
            }
            var message = "";
            message += "總共有:\(visionFaces.count)人\n"
            /*
            UIGraphicsBeginImageContextWithOptions(originalImage.size, false, 0)
            let context = UIGraphicsGetCurrentContext()!
            originalImage.draw(at: CGPoint.zero)
            context.setStrokeColor(UIColor.red.cgColor)
            context.setLineWidth(5)
            for (index,face) in visionFaces.enumerated(){
                message += "第\(index+1)臉的frame:\(face.frame)\n"
                context.addRect(face.frame)
            }
            context.drawPath(using: .stroke)
            if let newImage = UIGraphicsGetImageFromCurrentImageContext(){
                self.photoImageView.image = newImage
            }else{
                print("沒有畫成的圖片");
            }
            UIGraphicsEndImageContext()
            */
            
            let imageRender = UIGraphicsImageRenderer(size:originalImage.size)
            imageRender.image { _ in
                let context = UIGraphicsGetCurrentContext()!;
                originalImage.draw(at: CGPoint.zero)
                context.setStrokeColor(UIColor.red.cgColor)
                context.setLineWidth(5)
                for (index,face) in visionFaces.enumerated(){
                    message += "第\(index+1)臉的frame:\(face.frame)\n"
                    context.addRect(face.frame)
                }
                context.drawPath(using: .stroke)
                if let newImage = UIGraphicsGetImageFromCurrentImageContext(){
                    self.photoImageView.image = newImage
                }else{
                    print("沒有畫成的圖片");
                }
                
                
            }
            self.messageTextView.text = message
        }
        
        
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


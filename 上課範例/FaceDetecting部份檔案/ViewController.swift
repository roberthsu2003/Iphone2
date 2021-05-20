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
    @IBOutlet var messageTextView:UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func contourFaces(_ sender:UIButton){
        let options = FaceDetectorOptions()
        options.performanceMode = .accurate
        let faceDetector = FaceDetector.faceDetector(options: options)
        
        guard var originalImage = photoImageView.image else {return}
        print("imageSize=\(originalImage.size)")
        let visionImage = VisionImage(image: originalImage)
        
        faceDetector.process(visionImage) { (faces:[Face]?, error:Error?)in
            guard let faces = faces, !faces.isEmpty, error == nil else{
                print(error?.localizedDescription ?? "錯誤是nil")
                return
            }
            self.messageTextView.text = "人數=\(faces.count)"
            /*
            for faceInfo in faces{
                let frame = faceInfo.frame
                let faceView = UIView()
                faceView.frame = frame
                faceView.backgroundColor = UIColor.clear
                faceView.layer.borderColor = UIColor.red.cgColor
                faceView.layer.borderWidth = 2
                self.photoImageView.addSubview(faceView)
            }
            */
            
            for faceInfo in faces{
                originalImage = self.drawRectangleLine(faceFrame: faceInfo.frame, originImage: originalImage)
            }
            
            self.photoImageView.image = originalImage
            
            
            
            
        }
    }
    
    func drawRectangleLine(faceFrame:CGRect,originImage:UIImage)-> UIImage{
        let imageSize = originImage.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        originImage.draw(at: CGPoint.zero)
        context?.setFillColor(UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.8).cgColor)
        /*
        context?.fill([CGRect.init(x: 0, y: 0, width: 100, height: 100)])
        
        context?.fillEllipse(in: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        */
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(5.0)
        context!.addRect(faceFrame)
        context?.drawPath(using: .stroke)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func userClassification(_ sender:UIButton){
        let options = FaceDetectorOptions()
        options.performanceMode = .fast
        options.classificationMode = .all
        let faceDetector = FaceDetector.faceDetector(options: options)
        guard var originalImage = photoImageView.image else {return}
        let faceImage = VisionImage(image: originalImage)
        faceDetector.process(faceImage) { (faces:[Face]?, error:Error? ) in
            guard let faces = faces, !faces.isEmpty, error == nil else{
                print(error?.localizedDescription ?? "不知的錯誤")
                return
            }
            
            var message:String = "表情:"
            for face in faces{
                if face.hasSmilingProbability{
                    message += "開心\n"
                }else{
                    message += "不開心\n"
                }
                
                if face.hasRightEyeOpenProbability{
                    message += "右眼開\n"
                }else{
                    message += "右眼閉\n"
                }
                
                if face.hasLeftEyeOpenProbability{
                    message += "左眼開\n"
                }else{
                    message += "左眼閉\n"
                }
                message += "======================\n"
            }
            self.messageTextView.text = message
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


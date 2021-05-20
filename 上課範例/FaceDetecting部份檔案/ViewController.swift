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
        print("畫圖")
        return UIImage()
    }
    
    @IBAction func userClassification(_ sender:UIButton){
        
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


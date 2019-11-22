//
//  ViewController.swift
//  faceDetect
//
//  Created by 徐國堂 on 2019/11/22.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var photoImageView:UIImageView!;
    @IBOutlet var messageTextView:UITextView!
    lazy var vision = Vision.vision()
    
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
    
    @IBAction func countFaces(_ sender:UIButton){
        let options = VisionFaceDetectorOptions()
        options.performanceMode = .accurate
        let faceDetector = vision.faceDetector(options: options)
        guard let originalImage = photoImageView.image else{
            print("沒有選取圖片");
            return
        }
        let image = VisionImage(image: originalImage)
        faceDetector.process(image) { (visionFaces:[VisionFace]?, error:Error?) in
            guard let visionFaces = visionFaces, !visionFaces.isEmpty, error == nil else{
                print(error!.localizedDescription);
                return
            }
            
            for faceInfo in visionFaces{
                let frame = faceInfo.frame
                print(frame)
                self.drawRectangleLine(faceFrame: frame)
            }
            
            self.messageTextView.text = "人數=\(visionFaces.count)"
        }
        
    }
    
    func drawRectangleLine(faceFrame:CGRect){
        let faceView = UIView(frame: CGRect(x: 40, y: 50, width: 50, height: 50))
        faceView.backgroundColor = UIColor.clear
        faceView.layer.borderWidth = 1
        faceView.layer.borderColor = UIColor.red.cgColor
        photoImageView.addSubview(faceView)
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


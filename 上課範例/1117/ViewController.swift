//
//  ViewController.swift
//  barCode
//
//  Created by 徐國堂 on 2019/11/17.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var photoImageView:UIImageView!
    @IBOutlet var messageOfBarCodeRecognizer:UITextView!
    lazy var vision = Vision.vision()
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
    
    @IBAction func barCodeScan(_ sender:UIButton){
        //let formats = VisionBarcodeFormat(arrayLiteral: VisionBarcodeFormat.code39,VisionBarcodeFormat.qrCode)
        let formats = VisionBarcodeFormat.all
        let barcodeOptions = VisionBarcodeDetectorOptions(formats: formats)
        let barcodeDetector = vision.barcodeDetector(options: barcodeOptions)
        guard let originalImage = photoImageView.image else{
            showMessage(message: "沒有選擇圖片")
            return
        }
        let visionImage = VisionImage(image:originalImage)
        barcodeDetector.detect(in: visionImage) { (visionB:[VisionBarcode]?, error:Error?) in
            guard error == nil else{
                self.showMessage(message: "barCode辨識出錯:\(error!.localizedDescription)")
                return
            }
            
            guard let visionBarcodes = visionB,visionBarcodes.count > 0 else{
                self.showMessage(message: "barCode辨識出錯")
                return
            }
            
            for vistionBarcode in visionBarcodes{
                print(vistionBarcode.displayValue!);
                print("......................");
            }
            
        }
    }
    
    func showMessage(message:String){
        let alertController = UIAlertController(title: "錯誤", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
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

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
    @IBAction func userSelectedImage(_ sender:UIBarButtonItem){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self;
            imagePicker.allowsEditing = false;
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func barCodeScan(_ sender:UIButton){
        let barcodeOptions = BarcodeScannerOptions(formats: .all)
        let barcodeScanner = BarcodeScanner.barcodeScanner(options: barcodeOptions)
        guard let image = photoImageView.image else {return}
        let barcodeImage = VisionImage(image: image)
        barcodeScanner.process(barcodeImage) { (barcodes:[Barcode]?, error:Error?) in
            print("scanner完成")
            //顯示結果
            self.messageTextView.text = ""
            guard error == nil,let barcodes = barcodes, !barcodes.isEmpty else{
                print("掃描有問題")
                return
            }
            
            
            
            //處理barcodes 陣列
            for barcode in barcodes{
                let valueType = barcode.valueType
                switch valueType{
                case .wiFi:
                    self.messageTextView.text += "wifi\n"
                    if let ssid = barcode.wifi?.ssid{
                        self.messageTextView.text += "ssid:\(ssid)\n"
                    }
                    
                    if let password = barcode.wifi?.password{
                        self.messageTextView.text += "password:\(password)\n"
                    }
                    
                    if let encryptionType = barcode.wifi?.type{
                        self.messageTextView.text += "encryptionType:\(encryptionType)\n"
                    }
                    
                case .URL:
                    self.messageTextView.text += "url\n"
                    if let title = barcode.url?.title{
                        self.messageTextView.text += "title:\(title)"
                    }
                    
                    if let url = barcode.url?.url{
                        self.messageTextView.text += "url:\(url)"
                    }
                default:
                    self.messageTextView.text += "其它格式\n"
                    if let displayValue = barcode.displayValue{
                        self.messageTextView.text += "displayValue:\(displayValue)\n"
                    }
                }
                
                if let corners = barcode.cornerPoints{
                    for corner in corners{
                        var frameValue = CGRect(x: 0, y: 0, width: 0, height: 0)
                        corner.getValue(&frameValue)
                        self.messageTextView.text += "x:\(frameValue.origin.x)\n"
                        self.messageTextView.text += "y:\(frameValue.origin.y)\n"
                        self.messageTextView.text += "width:\(frameValue.size.width)\n"
                        self.messageTextView.text += "height:\(frameValue.size.height)\n"
                    }
                    
                    
                }
                self.messageTextView.text += "===================\n\n"
            }
            
        }
        print("跳出closure")
        
        
        
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


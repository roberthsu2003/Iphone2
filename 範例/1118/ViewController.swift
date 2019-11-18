//
//  ViewController.swift
//  barCode1
//
//  Created by 徐國堂 on 2019/11/18.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var phothImageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func selectImage(_ sender:UIBarButtonItem){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self;
            present(imagePickerController, animated: true, completion: nil)
        }
    }
}

extension ViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let originalImage = info[.originalImage] as? UIImage else{
            print("取得圖片錯誤");
            return
        }
        
        phothImageView.image = originalImage
        dismiss(animated: true, completion: nil)
    }
}


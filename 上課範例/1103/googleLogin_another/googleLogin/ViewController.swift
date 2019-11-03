//
//  ViewController.swift
//  googleLogin
//
//  Created by 徐國堂 on 2019/10/27.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    @IBOutlet var loginView:UIView!;
    weak var signInViewController:SignInViewController!;
    @IBOutlet var pickerSexView:UIView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginViewHeight = loginView.frame.size.height
        loginView.transform = CGAffineTransform(translationX: 0, y: loginViewHeight)
        
        //改變pickerViewController的位置
        
        let positionY = pickerSexView.frame.origin.y
        let pickerSexHeight = pickerSexView.frame.size.height;
        pickerSexView.transform = CGAffineTransform(translationX: 0, y: -(positionY + pickerSexHeight))

        
       
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser == nil {
                   //沒有登入
                   print("沒有登入，顯示登入畫面");
                   //performSegue(withIdentifier: "goLogin", sender: nil)
            UIView.animate(withDuration: 0.5) {
                self.loginView.transform = CGAffineTransform.identity
            }
            
               }else{
                   //已經登入
                   print("\(Auth.auth().currentUser!.uid)")
               }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSignin"{
            signInViewController = segue.destination as! SignInViewController
            signInViewController.viewController = self;
            
        }
        
    }
    
    @IBAction func userChangeSignIn(_ sender:UIBarButtonItem){
        signInViewController.view.backgroundColor = UIColor.white
    }
    
    func displayPickerSexView(){
        UIView.animate(withDuration: 0.5) {
            self.pickerSexView.transform = CGAffineTransform.identity;
        }
    }
    
    func disappearPickerSexView(){
        UIView.animate(withDuration: 0.5) {
            let positionY = self.pickerSexView.frame.origin.y
            let pickerSexHeight = self.pickerSexView.frame.size.height;
            self.pickerSexView.transform = CGAffineTransform(translationX: 0, y: -(positionY + pickerSexHeight))                  
       }
    }
    
    


}

extension ViewController:UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle{
        return .none
    }
    
   
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool{
        return false;
    }
}


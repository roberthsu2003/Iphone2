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
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginViewHeight = loginView.frame.size.height
        loginView.transform = CGAffineTransform(translationX: 0, y: loginViewHeight)
       
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
            let signInViewController = segue.destination as! SignInViewController
            signInViewController.viewController = self;
            
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


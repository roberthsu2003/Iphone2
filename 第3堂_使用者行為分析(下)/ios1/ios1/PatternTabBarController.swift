//範例參考來源https://firebase.google.com/
import UIKit
import Firebase

class PatternTabBarController: UITabBarController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        if getUserFavorieFood() == nil {
            askForFavoriteFood();
        }
    }
    
    @IBAction func didTapShare(_ sender: UIBarButtonItem) {
        let name = "Pattern!\(self.selectedViewController!.title!)";
        let text = "I'd love you to hear about \(name)";
        
        //傳送出自訂的LogEvent
        Analytics.logEvent("share_image", parameters: [
            "name": name as NSObject,
            "full_text": text as NSObject
            ]);
        
        let title = "Share:\(self.selectedViewController!.title!)";
        let message = "Share event sent to Analytics";
        let aleartConroller = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil);
        aleartConroller.addAction(alertAction);
        present(aleartConroller, animated: true, completion: nil);
    }
    
    @IBAction func unwindToHome(_ segue:UIStoryboardSegue){
        
    }

    func getUserFavorieFood() -> String?{
        return UserDefaults.standard.value(forKey: "favorite_food") as? String;
    }
    
    func askForFavoriteFood(){
        performSegue(withIdentifier: "pickFavoriteFood", sender: nil);
    }
    

}

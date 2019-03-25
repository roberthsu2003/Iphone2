//範例參考來源https://firebase.google.com/
import UIKit
import Firebase

class ViewController: UIViewController {

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        recordScreenView();
        
        //自訂的 custom_event
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title!)" as NSObject,
            AnalyticsParameterItemName:title! as NSObject,
            AnalyticsParameterContentType:"cont" as NSObject
            ]);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recordScreenView(){
        guard let screenName = title else{
            return;
        }
        
        let screenClass = classForCoder.description();
        
        print("screenName:\(screenName)");
        print("screenClass:\(screenClass)");
        
        Analytics.setScreenName(screenName, screenClass: screenClass);
    }


}


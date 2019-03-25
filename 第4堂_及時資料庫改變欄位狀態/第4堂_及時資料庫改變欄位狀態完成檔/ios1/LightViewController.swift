

import UIKit
import Firebase

class LightViewController: UIViewController {
    var relayRef:DatabaseReference!;
    @IBOutlet weak var lightBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        relayRef = Database.database().reference(withPath: "Relay/D1");
        relayRef.observe(.value) { (snapshot:DataSnapshot) in
            let d1State = snapshot.value as! Bool;
            if d1State {
                self.navigationItem.prompt = "目前狀態:開啟";
                self.lightBtn.setImage(UIImage.init(named: "open_light"), for: UIControl.State.normal);
            }else{
                self.navigationItem.prompt = "目前狀態:關閉";
                self.lightBtn.setImage(UIImage.init(named: "close_light"), for: UIControl.State.normal)
            }
        }
        
    }

    @IBAction func userChangeLight(_ sender: UIButton) {
       //連線取得一資料
        relayRef.observeSingleEvent(of: .value) { (snapshot:DataSnapshot) in
            let d1State = snapshot.value as! Bool;
            self.relayRef.setValue(!d1State);
        }
    }
    

}

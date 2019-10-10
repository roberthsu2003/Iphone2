
import UIKit
import Firebase
import Color_Picker_for_iOS

class RGBViewController: UIViewController {
    
    var rgbRef:DatabaseReference!;
    var colorPickerView:HRColorPickerView = HRColorPickerView();
   
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView.color = UIColor.blue;
        colorPickerView.frame = view.frame;
        colorPickerView.frame.origin.y = 20;
        colorPickerView.addTarget(self, action: #selector(colorChange), for: UIControl.Event.valueChanged);
        self.view.addSubview(colorPickerView);
        
        rgbRef = Database.database().reference(withPath: "RGB");
        rgbRef.observeSingleEvent(of:.value) { (snapshot:DataSnapshot) in
            let rgbValues = snapshot.value as! [String:Float];
            let r = rgbValues["R"]!;
            let g = rgbValues["G"]!;
            let b = rgbValues["B"]!;
            self.colorPickerView.color = UIColor(red: CGFloat(r/255.0)  , green: CGFloat(g/255.0) , blue: CGFloat(b/255.0), alpha: 1);
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }
    
    @objc func colorChange(_ sender:HRColorPickerView){
        var rValue:CGFloat = 0.0;
        var gValue:CGFloat = 0.0;
        var bValue:CGFloat = 0.0;
        var aValue:CGFloat = 0.0;
        sender.color.getRed(&rValue, green: &gValue, blue: &bValue, alpha: &aValue);
        let r = Int(rValue*255);
        let g = Int(gValue*255);
        let b = Int(bValue*255);
        
        self.rgbRef.setValue(["R":r,"G":g,"B":b]);
    }

   

}

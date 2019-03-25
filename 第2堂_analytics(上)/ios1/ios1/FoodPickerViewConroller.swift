//範例參考來源https://firebase.google.com/
import UIKit
import Firebase

class FoodPickerViewConroller: UIViewController {
    let foodStuffs = ["Hot Dogs", "Hamburger", "Pizza"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension FoodPickerViewConroller:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return foodStuffs[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let food = foodStuffs[row];
        UserDefaults.standard.set(food, forKey: "favorite_food");
        UserDefaults.standard.synchronize();
        
        Analytics.setUserProperty(food, forName: "favorite_food");
        
        performSegue(withIdentifier: "unwindToHome", sender: nil);
    }
}

extension FoodPickerViewConroller:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodStuffs.count;
    }
        
}



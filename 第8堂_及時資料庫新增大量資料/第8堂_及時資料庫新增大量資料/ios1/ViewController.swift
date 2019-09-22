//
//  ViewController.swift
//  ios1
//
//  Created by teacher on 2018/3/18.
//  Copyright © 2018年 teacher. All rights reserved.
//

import UIKit
import Firebase;

class ViewController: UIViewController {
    @IBOutlet var tableView:UITableView!;
    var authHandler:AuthStateDidChangeListenerHandle!;
    
    var keys = [String]();
    var namesDic = [String:[String]]();
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        authHandler = Auth.auth().addStateDidChangeListener { (auth:Auth, user:User?) in
            if user != nil {
                //self.tableView.reloadData();
                if self.keys.isEmpty{
                        let userNameRef = Database.database().reference(withPath: "iphone2/userName");
                        userNameRef.observe(.value){
                            (snapshot:DataSnapshot) -> Void in
                            if let userNamesValue = snapshot.value as? [String:[String:String]]{
                                
                                self.keys = Array(userNamesValue.keys).sorted();
                                
                                for key in self.keys{
                                    var names:[String] = [];
                                    let keyGroup = userNamesValue[key]!;
                                    for (_,userName) in keyGroup{
                                        names.append(userName);
                                    }
                                    
                                    self.namesDic[key] = names;
                                    
                                }
                            }
                            
                            //print("namsesDic=\(self.namesDic)");
                            self.tableView.reloadData();
                            }
                    
                }
            }
        }
        
        //先註冊，再login，login寫在註冊之後
        Auth.auth().signInAnonymously { (user:AuthDataResult?, error:Error?) in
            guard let myUser = user,  error == nil else{
                print("login 失敗");
                return;
            }
            
            print("使用者uid:\(myUser.user.uid)");
            
            
        }
        
        
        
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        Auth.auth().removeStateDidChangeListener(authHandler);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int{
        if keys.isEmpty {
            return 1;
        }
        return self.keys.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if keys.isEmpty {
            return 1;
        }
        let key = keys[section];
        let names = namesDic[key]!;
        return names.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if keys.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CELL1", for: indexPath);
            cell.textLabel?.text = "正在下載資料";
            
            return cell;
        }
        let key = keys[indexPath.section];
        let names = namesDic[key]!;
        let name = names[indexPath.row];
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL1", for: indexPath);
        cell.textLabel?.text = name;
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        if keys.isEmpty{
            return nil;
        }
        return keys[section];
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]?{
        if keys.isEmpty{
            return nil;
        }
        return keys;
    }
    
    
}

extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        /*
        let view = TitleView();
        view.backgroundColor = UIColor.red;
 */
        if keys.isEmpty{
            return nil;
        }
        let key = keys[section];
        
        let nib = UINib(nibName: "TitleView", bundle: nil);
        let views = nib.instantiate(withOwner: self, options: nil);
        let view = views[0] as! TitleView;
        view.titleLabel.text = key;

       
        return view;
    }
 
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 50.0;
    }
}


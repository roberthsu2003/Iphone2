//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/15.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var tableView:UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    var firestore = Firestore.firestore()
    var queryDocuments:[QueryDocumentSnapshot] = [QueryDocumentSnapshot]()
    
    var allQueryDocuments:[QueryDocumentSnapshot] = [QueryDocumentSnapshot]()
    
    lazy var presidents:[[String:String]] = {
        let pathURL = Bundle.main.url(forResource: "PresidentList", withExtension: "plist")
        guard let rootDictionary = NSDictionary(contentsOf: pathURL!) as? [String:Any] else{
            return [[:]]
        }
        let presidents = rootDictionary["presidents"]
        return presidents as! [[String:String]]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        //加入UISearchBar至tableView的Header
        let searchBar = searchController.searchBar
        tableView.tableHeaderView = searchBar
        //告知代理人
        searchController.searchResultsUpdater = self
        
        if Auth.auth().currentUser != nil{
            print("登入完成")
            doAnotherThing()
        }else{
            Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                guard let _ = result, error == nil else{
                    print("登入錯誤")
                    return
                }
                self.doAnotherThing()
            }
        }
    }

    func doAnotherThing(){
        /* 取得特定文件名稱的資料
        let docRef = firestore.collection("presidents").document("5Eg79ELFLfX4AYCNdyXJ")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print(document.get("name") as! String)
                print(document.get("url") as! String)
                print("有資料")
            } else {
                print("沒有資料")
            }
        }
 */
        
        //取得所有collection的documents
        firestore.collection("presidents").getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
            guard let snapshot = snapshot, error == nil else{
                print("取得所有documents失敗")
               return
            }
            if snapshot.isEmpty {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "匯入資料", style: .plain, target: self, action: #selector(self.uploadData(_:)))
            }else{
                self.queryDocuments = snapshot.documents
                self.allQueryDocuments = snapshot.documents
                self.tableView.reloadData()
                self.navigationItem.rightBarButtonItems = [
                    UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPresident(_:)))
                ]
                /*
                for queryDocument in self.queryDocuments{
                    print(queryDocument.data())
                }
                 */
            }
            
            
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail"{
            let name = sender as! String
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.name = name
            
        }else if segue.identifier == "goEdit"{
            let name = sender as! QueryDocumentSnapshot
            let editViewController = segue.destination as! EditViewController
            editViewController.queryDocumentSnapshot = name
            editViewController.getClosure {
                print("使用者按下Done了")
                self.doAnotherThing()
                self.tableView.reloadData()
                
            }
        }else if segue.identifier == "goAdd"{
            let addViewController = segue.destination as! AddViewController
            addViewController.registerCallBackData { (name:String, url:String) in
                print(name)
                print(url)
            }
        }
    }
    
    @objc func uploadData(_ sender:UIBarButtonItem){
        let batch = firestore.batch()
        for president in presidents{
            let documentRef = firestore.collection("presidents").document()
            batch.setData(president, forDocument: documentRef)
        }
        
        batch.commit { (error:Error?) in
            if error == nil{
                print("batch成功")
                self.navigationItem.rightBarButtonItems = [
                    UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
                ]
                self.doAnotherThing()
            }else{
                print("batch失敗")
            }
        }
    }
    
    @objc func addPresident(_ sender:UIBarButtonItem){
        performSegue(withIdentifier: "goAdd", sender: nil)
    }
}
// MARK: - UITableViewDataSource
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int{
        return queryDocuments.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let rowIndex = indexPath.row
        let queryDocument = queryDocuments[rowIndex]
        let data = queryDocument.data()
        let name = data["name"] as? String ?? ""
        let url = data["url"] as? String ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        if #available(iOS 15, *){
            var cellConfiguration = cell.defaultContentConfiguration()
            cellConfiguration.text = name
            cellConfiguration.secondaryText = url
            cell.contentConfiguration = cellConfiguration
        }else{
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = url
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView,
                     commit editingStyle: UITableViewCell.EditingStyle,
                     forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let indexRow = indexPath.row
            let queryDocumentSnapshot = queryDocuments[indexRow]
            let documentId = queryDocumentSnapshot.documentID
            firestore.collection("presidents").document(documentId).delete { (error:Error?) in
                if error == nil {
                    self.queryDocuments.remove(at: indexRow)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }else{
                    print("刪除錯誤")
                }
            }
            
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath){
        let indexRow = indexPath.row
        let queryDocumentSnapshot = queryDocuments[indexRow]
        guard let name = queryDocumentSnapshot.get("name") as? String else{
            return
        }
        performSegue(withIdentifier: "goDetail", sender: name)
        
        
    }
    
    func tableView(_ tableView: UITableView,
                   accessoryButtonTappedForRowWith indexPath: IndexPath){
        let indexRow = indexPath.row
        let queryDocumentSnapshot = queryDocuments[indexRow]
        /*
        guard let name = queryDocumentSnapshot.get("name") as? String else{
            return
        }
         */
        performSegue(withIdentifier: "goEdit", sender: queryDocumentSnapshot)
    }
}
// MARK: - UISearchResultsUpdatig
extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController){
        let searchBar = searchController.searchBar
        if let searchString = searchBar.text, searchString != ""{
            var searchQueryDocuments = [QueryDocumentSnapshot]()
            for queryDocumentSnapshot in allQueryDocuments{
                let name = queryDocumentSnapshot.get("name") as! String
                if name.contains(searchString){
                    searchQueryDocuments.append(queryDocumentSnapshot)
                }
            }
            self.queryDocuments = searchQueryDocuments
            
            
        }else{
            //搜尋的文字是空字串
            self.queryDocuments = self.allQueryDocuments
        }
        self.tableView.reloadData()
        
    }
}


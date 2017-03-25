//
//  TableViewController.swift
//  onsei2
//
//  Created by 原 あゆみ on 2017/02/20.
//  Copyright © 2017年 原 あゆみ. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift


class TableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var listLabel: UILabel!
    @IBOutlet var flagimage2: UIImageView!
    
    var realmUser : UserData!
    var Items: Results<UserData>!
    let newText = UserData()
    
   
    
   
    
    
    dynamic var flaglist = ["SaudiArabia.png","SouthAfrica.png","Thailand.png","Belgium.png"," Germany.png","Australia.png","UnitedStates.png","Brazil.png","Poland.png","Ireland.png","Greece.png","Indonesia.png","Sweden.png","Turkey.png","Portugal.png","Japan.png","Korea.png","Hungary.png","CzechRepublic.png","Denmark.png","Mexico.png","Canada.png","Netherlands.png","Finland.png","Spain.png","Italy.png","Romania.png","Norway.png","HongKong.png","Taiwan.png","Slovakia.png","China.png","Russia.png","UnitedKingdom.png","France.png","India.png"]
    
    


    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
                
        do{
            let realm = try Realm()
            Items = realm.objects(UserData.self)
            tableView.reloadData()
        }catch{
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        let count = Items.count
        return count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexpath: IndexPath)->UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        let object = Items[indexpath.row]
        
        cell.textLabel?.text = object.text
        cell.imageView?.image = UIImage(data: object.flag as Data)
//        flagimage.image = UIImage(named:flaglist[object.language])
            
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if(editingStyle == UITableViewCellEditingStyle.delete) {
            do{
                let realm = try Realm()
                try realm.write {
                    realm.delete(self.Items[indexPath.row])
                }
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }catch{
            }
            tableView.reloadData()
        }
    }
    
    
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
  
    
    @IBAction func save(_ sender: Any) {
        ViewController.tag = 2
        performSegue(withIdentifier: "toSecondViewController", sender: self)
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          ViewController.tag = 1
          ViewController.id = Items[indexPath.row].text
        

        performSegue(withIdentifier: "toSecondViewController", sender: self)
        
        print("タップされたセルのindex番号: \(indexPath.row)")
               
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toSecondViewController" {
               
            // 変数:遷移先ViewController型 = segue.destinationViewController as 遷移先ViewController型
            // segue.destinationViewController は遷移先のViewController
            
           
        }
        
    }
    
    
}

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    


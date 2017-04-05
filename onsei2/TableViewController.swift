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
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    static var sugoi : Int = 0
    static var onryou : Double = 0.0
    static var hayasa : Double = 0.0
    static var ontei : Double = 0.0

   
    
    
    
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
        
        let object : UserData = Items[indexpath.row]
        
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
    
    @IBAction func add1(_ sender: Any) {
        print("追加")
        self.performSegue(withIdentifier: "toSecondViewController", sender: nil)
    
              
    }
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    print("maple",ViewController.tag)
    
    let realm = try! Realm()
    let Items = realm.objects(UserData.self).filter("text == %@",ViewController.id)
   
    
    
        print( "huhu",Items.count)
        print("タグ", ViewController.tag)
        
        if  Items.count == 1 {
            
            print("tuuka")
            
            ViewController.textdefault = Items[0].text
            ViewController.tone2 = Items[0].tone
            ViewController.speed2 = Items[0].speed
            ViewController.volume2 = Items[0].volume
            ViewController.languageX = Items[0].language

            
            print(Items[0].text)
            print(Items[0].tone)
            print(Items[0].speed)
            print(Items[0].volume)
            print(Items[0].language)
            
            // 変数:遷移先ViewController型 = segue.destinationViewController as 遷移先ViewController型
            // segue.destinationViewController は遷移先のViewController
            
        }
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          ViewController.tag = 1
          ViewController.id = Items[indexPath.row].text
          TableViewController.sugoi = Items[indexPath.row].language
          TableViewController.onryou = Items[indexPath.row].volume
          TableViewController.hayasa = Items[indexPath.row].speed
          TableViewController.ontei = Items[indexPath.row].tone
          print("音量はこれくらい",Items[indexPath.row].language)
        
          print("すごーい",Items[indexPath.row].language)
        
        
        

        performSegue(withIdentifier: "toSecondViewController", sender: self)
        
        print("タップされたセルのindex番号: \(indexPath.row)")
        
        
               
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
    


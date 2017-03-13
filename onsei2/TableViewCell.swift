//
//  ListTableViewCell.swift
//  onsei2
//
//  Created by 原 あゆみ on 2017/02/20.
//  Copyright © 2017年 原 あゆみ. All rights reserved.
//

import UIKit
import RealmSwift

class ListTableViewCell: UITableViewCell {
    let realm = try! Realm()
    var Items: Results<UserData>!

    @IBOutlet var listLabel: UILabel!
    @IBOutlet var flagimage: UIImageView!
    
    var flaglist = ["Saudi Arabia.png","South Africa.png","Thailand.png","Belgium.png"," Germany.png","Australia.png","United States.png","Brazil.png","Poland.png","Ireland.png","Greece.png","Indonesia.png","Sweden.png","Turkey.png","Portugal.png","Japan.png","Korea.png","Hungary.png","Czech Republic.png","Denmark.png","Mexico.png","Canada.png","Netherlands.png","Finland.png","Spain.png","Italy.png","Romania.png","Norway.png","HongKong.png","Taiwan.png","Slovakia.png","China.png","Russia.png","United Kingdom.png","France.png","India.png"]
    
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
                

        // Configure the view for the selected state
    }
    
    
    
        
    

    
    
    
}

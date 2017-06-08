//
//  SpecialStoryController.swift
//  SpotMeSpecial2017
//
//  Created by csie_02 on 2017/5/30.
//  Copyright © 2017年 csie_02. All rights reserved.
//

import UIKit

class SpecialStoryController: UIViewController {
    
    var data: String?
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if data == "Guest" {
            lbTitle.text = "全程 準時 參與"
            tvContent.text = "Guest Story"
        } else {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

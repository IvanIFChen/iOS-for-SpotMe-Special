//
//  SpecialStoryController.swift
//  SpotMeSpecial2017
//
//  Created by csie_02 on 2017/5/30.
//  Copyright © 2017年 csie_02. All rights reserved.
//

import UIKit

class SpecialStoryController: UIViewController {
    
    var index = 0
    var storyFiles: [String: [String]] = [: ]
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromFile(externalFileNames: ["name", "D_title", "D_content"])
        
        loadDStory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadDStory() {
        lbTitle.text = storyFiles["D_title"]![index]
        tvContent.text = storyFiles["D_content"]![index]
    }
    
    func loadFromFile(externalFileNames: [String]) {
        
        for i in 0 ..< externalFileNames.count {
            let fileName = externalFileNames[i]
            if let path = Bundle.main.path(forResource: fileName, ofType: "") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)    // short for String.Encoding.utf8
                    let myStrings = data.components(separatedBy: "</br>")           // seperator is "</br>"
                    self.storyFiles.updateValue(myStrings, forKey: fileName)
                } catch {
                    print(error)
                }
            }
        }
    }

}

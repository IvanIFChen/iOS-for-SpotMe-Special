//
//  ViewController.swift
//  SpotMe2017_170516
//
//  Created by csie_02 on 2017/5/16.
//  Copyright © 2017年 csie_02. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let storyNums = 128

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var lbCate: UILabel!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var storyList : [String: [String]] = [:]
    
    var current = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromFile(externalFileNames: ["title", "content", "category"])
        
        loadStory()
        btnPrev.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func prevStory(_ sender: UIButton) {
        if current > 0 {
            current -= 1
            loadStory()
            if current == 0 {
                btnPrev.isEnabled = false
            }
        }
        if current <= storyNums {
            btnNext.isEnabled = true
        }
    }

    @IBAction func nextStory(_ sender: UIButton) {
        if current <= storyNums {
            current += 1
            loadStory()
            if current == storyNums - 1 {
                btnNext.isEnabled = false
            }
        }
        if current > 0 {
            btnPrev.isEnabled = true
        }
    }
    
    func loadStory() {
        navBar.prompt = "第 \(current) 篇"
        // TODO: use storyList
        lbTitle.text = storyList["title"]![current]
        tvContent.text = storyList["content"]![current]
        lbCate.text = storyList["category"]![current]
    }
    
    func loadFromFile(externalFileNames: [String]) {
        
        for i in 0 ..< externalFileNames.count {
            let fileName = externalFileNames[i]
            if let path = Bundle.main.path(forResource: fileName, ofType: "") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)    // short for String.Encoding.utf8
                    let myStrings = data.components(separatedBy: "</br>")           // seperator is "</br>"
                    self.storyList.updateValue(myStrings, forKey: fileName)
                } catch {
                    print(error)
                }
            }
        }
    }
}


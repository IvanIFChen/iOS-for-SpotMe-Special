//
//  ViewController.swift
//  SpotMeSpecial2017
//
//  Created by csie_02 on 2017/5/16.
//  Copyright © 2017年 csie_02. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let storyNums = 128

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var lbCate: UILabel!
    @IBOutlet weak var lbStoryNum: UILabel!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var storyList: [String: [String]] = [: ]
    
    var current = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromFile(externalFileNames: ["title", "content", "category"])
        
        loadStory()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Shake to load random story.
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            let randomNum = Int(arc4random() % UInt32(storyNums))
            current = randomNum
            loadStory()
        }
    }
    
    @IBAction func prevBtnPressed(_ sender: UIButton) {
        prevStory()
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        nextStory()
    }

    func prevStory() {
        if current == 0 {
            current = storyNums - 1
        } else {
            current -= 1
        }
        loadStory()
    }
    
    func nextStory() {
        if current == 127 {
            current = 0
        } else {
            current += 1
        }
        loadStory()
    }
    
    func loadStory() {
        Analytics.logEvent("main_page", parameters: [
            "view_story": current as NSObject
            ])
        
        lbStoryNum.text = "No.\(current)"
        lbTitle.text = storyList["title"]![current]
        tvContent.text = storyList["content"]![current]
        navBar.title = storyList["category"]![current]
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        nextStory()
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        prevStory()
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


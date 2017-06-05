//
//  InsertNameController.swift
//  SpotMe2017_170516
//
//  Created by csie_02 on 2017/5/30.
//  Copyright © 2017年 csie_02. All rights reserved.
//

import UIKit

class InsertNameController: UIViewController {
    
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var typeIn: UITextField!
    
    var name = "Guest"
    let users = [
    ["user", "123"],
    ["test", "test123"],
    ["hi", "hi123"],
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Special"
        btnOK.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func checkWords(_ sender: UITextField) {
        if typeIn.text == "" {
            btnOK.isEnabled = false
        } else {
            btnOK.isEnabled = true
        }
    }
    
    @IBAction func typeFin(_ sender: UIButton) {
        for user in users[0] {
            if user == typeIn.text! {
                
            }
        }
        name = typeIn.text!
    }
    
    @IBAction func enterGuest(_ sender: UIButton) {
        let alert = UIAlertController(title: "請輸入通關密語", message: "主顧榮譽書院的基本要求。(6字)", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: { ACTION in
            if let passwdTextField = alert.textFields?[0] {
                print(passwdTextField.text!)
                if passwdTextField.text == "全程準時參與" {
                    self.performSegue(withIdentifier: "toGuestStory", sender: self)
                } else {
                    print("wrong passwd")
                    let wrongPasswdAlert = UIAlertController(title: "錯誤", message: "請再試一次", preferredStyle: .alert)
                    wrongPasswdAlert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
                    self.present(wrongPasswdAlert, animated: true, completion: nil)
                }
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGuestStory" {
            let pass = segue.destination as! SpecialStoryController
            let data = "Guest"
            pass.data = data
        }
        
        if segue.identifier == "Login" {
            let pass = segue.destination as! SpecialStoryController
            let data = name
            pass.data = data
        }
    }
    
}

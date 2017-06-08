//
//  InsertNameController.swift
//  SpotMeSpecial2017
//
//  Created by csie_02 on 2017/5/30.
//  Copyright © 2017年 csie_02. All rights reserved.
//

import UIKit
import Firebase

class InsertNameController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var typeIn: UITextField!
    
    var loginFiles: [String: [String]] = [: ]
    
    var index = 0
    var account = "Default"
    
    var loginHint = "主顧榮譽書院的基本要求。(6字)"
    var loginKey = "全程準時參與"
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Special"
        btnOK.isEnabled = false
        typeIn.delegate = self
        
        loadFromFile(externalFileNames: ["name", "hint", "key"])
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
    
    @IBAction func typeFinish(_ sender: UIButton) {
        index = 0
        for name in loginFiles["name"]! {
            if name == typeIn.text! {
                account = name
                break
            } else {
                index = index + 1
            }
            print(account)
            
        }
        print(index)
        if index >= (loginFiles["name"]!.count) || index == 0 {
            account = "Default"
            let wrongPasswdAlert = UIAlertController(title: "錯誤", message: "請再試一次", preferredStyle: .alert)
            wrongPasswdAlert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
            self.present(wrongPasswdAlert, animated: true, completion: nil)

        } else {
            loginByKey()
        }
        print(account)
    }
    
    @IBAction func enterGuest(_ sender: UIButton) {
        index = 0
        loginByKey()
    }
    
    func loginByKey() {
        loginHint = loginFiles["hint"]![index]
        loginKey = loginFiles["key"]![index]
        
        let alert = UIAlertController(title: "請輸入通關密語", message: loginHint, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: { ACTION in
            if let passwdTextField = alert.textFields?[0] {
                print(passwdTextField.text!)
                if passwdTextField.text == self.loginKey {
                    self.performSegue(withIdentifier: "Login", sender: self)
                } else {
                    print("wrong passwd")
                    // log the attempted password
                    Analytics.logEvent("insert_name", parameters: [
                        "wrong_password": passwdTextField.text! as NSObject
                        ])
                    let wrongPasswdAlert = UIAlertController(title: "通關密語錯誤", message: "請再試一次", preferredStyle: .alert)
                    wrongPasswdAlert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
                    self.present(wrongPasswdAlert, animated: true, completion: nil)
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pass = segue.destination as! SpecialStoryController
        pass.index = index
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        typeIn.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        typeIn.resignFirstResponder()
        return true
    }
    
    func loadFromFile(externalFileNames: [String]) {
        
        for i in 0 ..< externalFileNames.count {
            let fileName = externalFileNames[i]
            if let path = Bundle.main.path(forResource: fileName, ofType: "") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)    // short for String.Encoding.utf8
                    let myStrings = data.components(separatedBy: "</br>")           // seperator is "</br>"
                    self.loginFiles.updateValue(myStrings, forKey: fileName)
                } catch {
                    print(error)
                }
            }
        }
    }
}

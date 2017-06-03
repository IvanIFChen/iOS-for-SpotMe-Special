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
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "guestLogin" {
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

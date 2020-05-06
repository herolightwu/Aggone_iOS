//
//  ChangePasswordVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/24/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_current_pass: UILabel!
    @IBOutlet weak var lb_new_pass: UILabel!
    @IBOutlet weak var lb_retype_pass: UILabel!
    @IBOutlet weak var btn_confirm: UIButton!
    @IBOutlet weak var txt_current: UITextField!
    @IBOutlet weak var txt_new: UITextField!
    @IBOutlet weak var txt_retype: UITextField!
    
    var hud: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setViewController(){
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        lb_title.text = getString(key: "menu_change_password")
        lb_current_pass.text = getString(key: "current_password")
        lb_new_pass.text = getString(key: "new_password")
        lb_retype_pass.text = getString(key: "retype_password")
        btn_confirm.setTitle(getString(key: "btn_confirm"), for: .normal)
        if UserDefaults.standard.bool(forKey: Constants.LOGIN_ISLOGGEDIN) {
            txt_current.text = UserDefaults.standard.string(forKey: Constants.LOGIN_PASSWORD)
        }
    }

    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        let cur_pass = txt_current.text!
        let new_pass = txt_new.text!
        let retype_pass = txt_retype.text!
        if cur_pass.isEmpty {
            showToast(message: "Please input password")
            return
        }
        if new_pass.isEmpty {
            showToast(message: "Please input new password")
            return
        }
        if new_pass != retype_pass {
            showToast(message: "Invalid confirm password")
            return
        }
        if new_pass == cur_pass {
            showToast(message: "New password is wrong")
            return
        }
        
        let current_pass = UserDefaults.standard.string(forKey: Constants.LOGIN_PASSWORD)
        if cur_pass != current_pass {
            showToast(message: "Current password is wrong")
            return
        }
        
        hud.show(in: view)
        API.changePassword(password: new_pass, onSuccess: { response in
            self.hud.dismiss()
            UserDefaults.standard.set(new_pass, forKey: Constants.LOGIN_PASSWORD)
            self.actionBack()
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }
    
}

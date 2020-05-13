//
//  ForgotPasswordDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol ForgotPasswordDialogDelegate {
    func onClickOk(email: String)
}

class ForgotPasswordDialog: UIViewController {
    
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var btn_ok: UIButton!
    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var text_value: UITextField!
    @IBOutlet weak var view_value: UIView!
    
    var delegate : ForgotPasswordDialogDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true
        
        btn_ok.layer.cornerRadius = 4
        btn_ok.clipsToBounds = true
        
        btn_cancel.layer.cornerRadius = 4
        btn_cancel.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_cancel.layer.borderWidth = 1
        btn_cancel.clipsToBounds = true
        
        view_value.layer.cornerRadius = 9
        view_value.clipsToBounds = true
        
        text_value.placeholder = getString(key: "pf_email")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickOk(_ sender: Any) {
        if (text_value.text?.isEmpty)! {
            self.showToast(message: "Please input email")
            return
        }
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickOk(email: self.text_value.text!)
            }
        })
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.actionBack()
    }
    
}

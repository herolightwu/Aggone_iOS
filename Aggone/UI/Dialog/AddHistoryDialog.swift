//
//  AddHistoryDialog.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/28/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol AddHistoryDialogDelegate {
    func onHistoryDone()
}

class AddHistoryDialog: UIViewController {
    
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var txt_description: UITextView!
    
    var delegate: AddHistoryDialogDelegate!
    var hud: JGProgressHUD!
    
    var sTitle: String! = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"

        if !AppData.user.desc_str.isEmpty {
            txt_description.text = AppData.user.desc_str
        }
        if !sTitle.isEmpty {
            lb_title.text = sTitle
        }
    }

    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        if txt_description.text.isEmpty {
            showToast(message: "Please input your Bio...")
            return
        }
        hud.show(in: view)
        API.updateUserFields(fieldname: "desc_str", fieldvalue: txt_description.text!, onSuccess: { response in
            self.hud.dismiss()
            AppData.user = response
            self.actionBack(completion: {
                if self.delegate != nil {
                    self.delegate.onHistoryDone()
                }
            })
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
        
    }
}

//
//  TextInputDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol TextInputDialogDelegate {
    func onClickOk(text: String, value: String)
}

class TextInputDialog: UIViewController {
    
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var btn_ok: UIButton!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var text_value: UITextField!
    @IBOutlet weak var view_value: UIView!
    
    var delegate : TextInputDialogDelegate!
    var text: String!
    var value: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true
        
        btn_ok.layer.cornerRadius = 4
        btn_ok.clipsToBounds = true
        
        view_value.layer.cornerRadius = 9
        view_value.clipsToBounds = true
        
        label_title.text = text
        text_value.text = value
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickOk(_ sender: Any) {
        if (text_value.text?.isEmpty)! {
            self.showToast(message: "Please input " + text)
            return
        }
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickOk(text: self.text, value: self.text_value.text!)
            }
        })
    }
}

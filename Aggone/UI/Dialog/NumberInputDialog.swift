//
//  NumberInputDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol NumberInputDialogDelegate {
    func onClickOk(index: Int, value: String)
    func onClickOk(club:String!, section: Int!, index: Int, value: String)
}

class NumberInputDialog: UIViewController {
    
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var btn_ok: UIButton!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var text_value: UITextField!
    @IBOutlet weak var view_value: UIView!
    
    var index: Int!
    var delegate : NumberInputDialogDelegate!
    var text: String!
    var section: Int!
    var club:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true
        
        btn_ok.layer.cornerRadius = 4
        btn_ok.clipsToBounds = true
        
        view_value.layer.cornerRadius = 9
        view_value.clipsToBounds = true
        
        label_title.text = text
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
                if self.club.isEmpty{
                    self.delegate.onClickOk(index: self.index, value: self.text_value.text!)
                } else {
                    self.delegate.onClickOk(club: self.club, section: self.section, index: self.index, value: self.text_value.text!)
                }
            }
        })
    }
}

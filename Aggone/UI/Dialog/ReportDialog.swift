//
//  ReportDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol ReportDialogDelegate {
    func onClickOk(text: String)
}

class ReportDialog: UIViewController {

    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var text_value: UITextView!
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var btn_ok: UIButton!
    
    var delegate : ReportDialogDelegate!
    var text: String!
    var value:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true
        
        btn_ok.layer.cornerRadius = 4
        btn_ok.clipsToBounds = true
        label_title.text = text
        text_value.text = value
    }
    
    func setTitle(text: String) {
        self.text = text
    }
    
    @IBAction func onClickOk(_ sender: Any) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickOk(text: self.text_value.text)
            }
        })
    }
    
    
    @IBAction func onClickClose(_ sender: Any) {
        self.actionBack()
    }
}

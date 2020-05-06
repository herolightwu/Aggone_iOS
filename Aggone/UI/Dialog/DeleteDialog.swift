//
//  DeleteDialog.swift
//  Aggone
//
//  Created by Tiexong Li on 2019/4/22.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

class DeleteDialog: UIViewController {

    @IBOutlet weak var view_panel: UIView!
    
    var handler: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickDelete(_ sender: Any) {
        self.actionBack(completion: {
            if self.handler != nil {
                self.handler()
            }
        })
    }
}

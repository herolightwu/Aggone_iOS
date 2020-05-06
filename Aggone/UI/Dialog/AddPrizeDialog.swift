//
//  AddPrizeDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

protocol AddPrizeDialogDelegate {
    func onClickSubmit(title: String, club: String, year: String, icon: Int)
}

class AddPrizeDialog: UIViewController {
    
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var view_title: UIView!
    @IBOutlet weak var text_title: UITextField!
    @IBOutlet weak var view_club: UIView!
    @IBOutlet weak var text_club: UITextField!
    @IBOutlet weak var view_year: UIView!
    @IBOutlet weak var text_year: UITextField!
    @IBOutlet weak var btn_submit: UIButton!

    @IBOutlet weak var view_prize1: UIView!
    @IBOutlet weak var view_prize2: UIView!
    @IBOutlet weak var view_prize3: UIView!
    @IBOutlet weak var view_prize4: UIView!
    @IBOutlet weak var view_prize5: UIView!
    
    var delegate : AddPrizeDialogDelegate!
    var icon: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true

        view_title.layer.cornerRadius = 9
        view_title.clipsToBounds = true
        view_club.layer.cornerRadius = 9
        view_club.clipsToBounds = true
        view_year.layer.cornerRadius = 9
        view_year.clipsToBounds = true
        
        btn_submit.layer.cornerRadius = 4
        btn_submit.clipsToBounds = true
        
        clearIcons()
    }
    
    func clearIcons() {
        view_prize1.alpha = 0.5
        view_prize2.alpha = 0.5
        view_prize3.alpha = 0.5
        view_prize4.alpha = 0.5
        view_prize5.alpha = 0.5
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickPrize1(_ sender: Any) {
        icon = Constants.PRIZE1
        clearIcons()
        view_prize1.alpha = 1.0
    }
    
    @IBAction func onClickPrize2(_ sender: Any) {
        icon = Constants.PRIZE2
        clearIcons()
        view_prize2.alpha = 1.0
    }
    
    @IBAction func onClickPrize3(_ sender: Any) {
        icon = Constants.PRIZE3
        clearIcons()
        view_prize3.alpha = 1.0
    }
    
    @IBAction func onClickPrize4(_ sender: Any) {
        icon = Constants.PRIZE4
        clearIcons()
        view_prize4.alpha = 1.0
    }
    
    @IBAction func onClickPrize5(_ sender: Any) {
        icon = Constants.PRIZE5
        clearIcons()
        view_prize5.alpha = 1.0
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        if (text_title.text?.isEmpty)! {
            self.showToast(message: "Please input title")
            return
        }
        if (text_club.text?.isEmpty)! {
            self.showToast(message: "Please input club")
            return
        }
        if (text_year.text?.isEmpty)! {
            self.showToast(message: "Please input year")
            return
        }
        if icon == -1 {
            self.showToast(message: "Please select icon")
            return
        }
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickSubmit(title: self.text_title.text!, club: self.text_club.text!, year: self.text_year.text!, icon: self.icon)
            }
        })
    }
}

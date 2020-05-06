//
//  StrengthVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/22/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class StrengthVC: UIViewController {

    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var view_first: UIView!
    @IBOutlet weak var view_second: UIView!
    @IBOutlet weak var view_third: UIView!
    @IBOutlet weak var lb_first: UILabel!
    @IBOutlet weak var lb_second: UILabel!
    @IBOutlet weak var lb_third: UILabel!
    @IBOutlet weak var img_photo: UIImageView!
    
    var user: User!
    var strengths: [String] = []
    var hud: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        getAllStrengths()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupVC(){
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        if user.photo_url.isEmpty {
            img_photo.image = UIImage(named: "default_avata")
        } else {
            if user.photo_url.contains("http") {
                img_photo.sd_setImage(with: URL(string: user.photo_url), placeholderImage: nil)
            } else{
                img_photo.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + user.photo_url), placeholderImage: nil)
            }
        }
        if user.id == AppData.user.id {
            btn_edit.isHidden = false
        } else {
            btn_edit.isHidden = true
        }
        view_first.isHidden = true
        view_second.isHidden = true
        view_third.isHidden = true
    }
    
    func getAllStrengths(){
        hud.show(in: view)
        API.getStrengths(uid: user.id, onSuccess: { response in
            self.hud.dismiss()
            self.view_first.isHidden = true
            self.view_second.isHidden = true
            self.view_third.isHidden = true
            if response.count > 0 {
                let strength1 = Int(response[0])!
                var ssid = strength1 / 100
                var stid = strength1 % 100
                self.strengths = self.configureStrength(sid: ssid)
                if self.strengths.count > 0 && stid < self.strengths.count {
                    self.lb_first.text = self.strengths[stid]
                    self.view_first.isHidden = false
                }
                if response.count > 1 {
                    let strength2 = Int(response[1])!
                    ssid = strength2 / 100
                    stid = strength2 % 100
                    self.strengths = self.configureStrength(sid: ssid)
                    if self.strengths.count > 0 && stid < self.strengths.count {
                        self.lb_second.text = self.strengths[stid]
                        self.view_second.isHidden = false
                    }
                    if response.count > 2 {
                        let strength3 = Int(response[2])!
                        ssid = strength3 / 100
                        stid = strength3 % 100
                        self.strengths = self.configureStrength(sid: ssid)
                        if self.strengths.count > 0 && stid < self.strengths.count {
                            self.lb_third.text = self.strengths[stid]
                            self.view_third.isHidden = false
                        }
                    }
                }
            }
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }
    
    @IBAction func onClickBAck(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickEdit(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EditStrengthVC") as! EditStrengthVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//
//  ProfileHistoryVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/20/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class ProfileHistoryVC: UIViewController {

    @IBOutlet weak var lb_biology: UILabel!
    @IBOutlet weak var lb_details: UILabel!
    @IBOutlet weak var lb_city_title: UILabel!
    @IBOutlet weak var lb_city: UILabel!
    @IBOutlet weak var view_city: UIView!
    @IBOutlet weak var view_details: UIView!
    @IBOutlet weak var view_email: UIView!
    @IBOutlet weak var lb_email_title: UILabel!
    @IBOutlet weak var lb_email: UILabel!
    @IBOutlet weak var view_country: UIView!
    @IBOutlet weak var lb_ct_title: UILabel!
    @IBOutlet weak var lb_country: UILabel!
    @IBOutlet weak var view_phone: UIView!
    @IBOutlet weak var lb_phone_title: UILabel!
    @IBOutlet weak var lb_phone: UILabel!
    @IBOutlet weak var view_web: UIView!
    @IBOutlet weak var lb_web_title: UILabel!
    @IBOutlet weak var lb_website: UILabel!
    @IBOutlet weak var btn_bio: UIButton!
    @IBOutlet weak var btn_email: UIButton!
    @IBOutlet weak var btn_phone: UIButton!
    @IBOutlet weak var bnt_web: UIButton!
    
    var parentVC: ProfileViewController!
    var user:User!
    
    var hud: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setVC(){
        lb_details.text = getString(key: "pf_details")
        lb_city_title.text = getString(key: "txt_city")
        lb_ct_title.text = getString(key: "txt_country")
        lb_email_title.text = getString(key: "pf_email")
        lb_phone_title.text = getString(key: "pf_phone")
        lb_web_title.text = getString(key: "pf_website")
        
        lb_city.text = user.city
        lb_country.text = user.country
        lb_email.text = user.email
        lb_phone.text = user.phone
        lb_website.text = user.web_url
        if !user.desc_str.isEmpty {
            lb_biology.text = user.desc_str
        }
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        if user.id != AppData.user.id {
            btn_bio.isHidden = true
            btn_email.isHidden = true
            btn_phone.isHidden = true
            bnt_web.isHidden = true
        }
    }
    
    @IBAction func onClickBio(_ sender: Any) {
        if user.id != AppData.user.id { return }
//        let controller : ReportDialog = ReportDialog.init(nibName: "ReportDialog", bundle: nil)
//        controller.modalPresentationStyle = .overFullScreen
//        controller.modalTransitionStyle = .crossDissolve
//        controller.delegate = self
//        controller.text = getString(key: "pf_history")
//        controller.value = lb_biology.text
//        present(controller, animated: true, completion: nil)
        let controller = AddHistoryDialog.init(nibName: "AddHistoryDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.sTitle = getString(key: "pf_history")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickEmailEdit(_ sender: Any) {
        let controller = TextInputDialog.init(nibName: "TextInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.text = getString(key: "pf_email")
        controller.value = lb_email.text
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickPhoneEdit(_ sender: Any) {
        let controller = TextInputDialog.init(nibName: "TextInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.text = getString(key: "pf_phone")
        controller.value = lb_phone.text
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickWebEdit(_ sender: Any) {
        let controller = TextInputDialog.init(nibName: "TextInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.text = getString(key: "pf_website")
        controller.value = lb_website.text
        present(controller, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidPhone(testStr: String) -> Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: testStr, options: [], range: NSRange(location: 0, length: testStr.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == testStr.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func isValidURL(testStr: String) -> Bool {
        if let url = URL(string: testStr) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}

extension ProfileHistoryVC: TextInputDialogDelegate {
    func onClickOk(text: String, value: String) {
        if text == getString(key: "pf_email") {
            if isValidEmail(testStr: value) {
                hud.show(in: view)
                API.updateUserFields(fieldname: "email", fieldvalue: value, onSuccess: { response in
                    self.hud.dismiss()
                    AppData.user = response
                    self.lb_email.text = response.email
                }, onFailed: {err in
                    self.hud.dismiss()
                    self.showToast(message: err)
                })
            } else{
                showToast(message: "Invalid email")
                return
            }
        } else if text == getString(key: "pf_phone") {
            if isValidPhone(testStr: value) {
                hud.show(in: view)
                API.updateUserFields(fieldname: "phone", fieldvalue: value, onSuccess: { response in
                    self.hud.dismiss()
                    AppData.user = response
                    self.lb_phone.text = response.phone
                }, onFailed: {err in
                    self.hud.dismiss()
                    self.showToast(message: err)
                })
            } else{
                showToast(message: "Invalid Phone Number")
                return
            }
        } else if text == getString(key: "pf_website") {
            if isValidURL(testStr: value) {
                hud.show(in: view)
                API.updateUserFields(fieldname: "web_url", fieldvalue: value, onSuccess: { response in
                    self.hud.dismiss()
                    AppData.user = response
                    self.lb_website.text = response.web_url
                }, onFailed: {err in
                    self.hud.dismiss()
                    self.showToast(message: err)
                })
            } else{
                showToast(message: "Invalid URL Address")
                return
            }
        }
    }
}

extension ProfileHistoryVC: AddHistoryDialogDelegate {
    func onHistoryDone() {
        self.lb_biology.text = AppData.user.desc_str
    }
//    func onClickOk(text: String) {
//        hud.show(in: view)
//        API.updateUserFields(fieldname: "desc_str", fieldvalue: text, onSuccess: { response in
//            self.hud.dismiss()
//            AppData.user = response
//            self.lb_biology.text = response.desc_str
//        }, onFailed: {err in
//            self.hud.dismiss()
//            self.showToast(message: err)
//        })
//    }
}

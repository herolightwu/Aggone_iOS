//
//  RegisterViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/15/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class RegisterViewController: UIViewController {


    @IBOutlet var text_email: UITextField!
    @IBOutlet var text_password: UITextField!
    @IBOutlet var text_password_confirmation: UITextField!
    @IBOutlet weak var btn_check: ImageCheckBox!
    
    var isCheckedTerms: Bool = false
    var hud: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        btn_check.isChecked = isCheckedTerms
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func onClickValidate(_ sender: Any) {
        if (text_email.text?.isEmpty)! {
            showToast(message: "Please input email")
            return
        }
        if (!isValidEmail(testStr: text_email.text!)) {
            showToast(message: "Invalid email")
            return
        }
        if (text_password.text?.isEmpty)! {
            showToast(message: "Please input password")
            return
        }
        if (text_password_confirmation.text?.isEmpty)! {
            showToast(message: "Please input confirm password")
            return
        }
        if (text_password.text != text_password_confirmation.text) {
            showToast(message: "Invalid confirm password")
            return
        }
        if isCheckedTerms == false {
            showToast(message: "Please read terms and conditions")
            return
        }
        hud.show(in: view)
        API.getUserByEmail(email: text_email.text!, onSuccess: ({user in
            self.hud.dismiss()
            self.showToast(message: "This email address is already used")
        }), onFailed: ({error in
            self.hud.dismiss()
            if (error == "Don't exist") {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "SignUpInfoViewController") as! SignUpInfoViewController
                controller.email = self.text_email.text
                controller.password = self.text_password.text
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                self.showJHTAlertOkayAction(message: error, action: nil)
            }
        }))
    }

    @IBAction func onClickLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickPrivacy(_ sender: Any) {
        isCheckedTerms = true
        btn_check.isChecked = isCheckedTerms
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//
//  LoginViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/15/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import JHTAlertController
import JGProgressHUD
import GoogleSignIn
import AuthenticationServices


class LoginViewController: UIViewController {

    @IBOutlet var text_email: UITextField!
    @IBOutlet var text_password: UITextField!
    @IBOutlet weak var btn_Apple: UIButton!
    
    var hud: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
        if UserDefaults.standard.bool(forKey: Constants.LOGIN_ISLOGGEDIN) {
            text_email.text = UserDefaults.standard.string(forKey: Constants.LOGIN_EMAIL)
            text_password.text = UserDefaults.standard.string(forKey: Constants.LOGIN_PASSWORD)
            onClickSignin(AnyClass.self)
        }
        
        btn_Apple.layer.cornerRadius = 25
        btn_Apple.layer.shadowColor = UIColor.darkGray.cgColor
        btn_Apple.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        btn_Apple.layer.shadowRadius = 1.0
        btn_Apple.layer.shadowOpacity = 0.5
        btn_Apple.layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            btn_Apple.isHidden = false
        } else{
            btn_Apple.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    //function is fetching the user data
    func getFBUserData(){
        if(AccessToken.current != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, picture.type(large), first_name, last_name"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    let dict : [String : AnyObject] = result as! [String : AnyObject]
                    let email = dict["email"] as! String
                    let first_name = dict["first_name"] as! String
                    let last_name = dict["last_name"] as! String
                    let picture = dict["picture"] as! [String : AnyObject]
                    let data = picture["data"] as! [String : AnyObject]
                    let url = data["url"] as! String
                    self.hud.show(in: self.view)
                    API.loginWithSocial(email: email, username: first_name + " " + last_name, photo_url: url, onSuccess: { response in
                        self.hud.dismiss()
                        AppData.user = response
                        if AppData.user.sport > 500{
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
                            controller.modalPresentationStyle = .overFullScreen
                            controller.modalTransitionStyle = .crossDissolve
                            self.navigationController?.present(controller, animated: true, completion: nil)
                        } else{
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "SignUpInfoViewController") as! SignUpInfoViewController
                            controller.email = AppData.user.email
                            controller.password = ""
                            controller.signup_mode = Constants.SIGNUP_SOCIAL
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                        
                    }, onFailed: { error in
                        self.hud.dismiss()
                        self.showToast(message: error)
                    })
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func onClickSignin(_ sender: Any) {
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
        hud.show(in: view)
        API.loginWithEmailAndPassword(email: text_email.text!, password: text_password.text!, onSuccess: ({user in
            self.hud.dismiss()
            AppData.user = user
            UserDefaults.standard.set(true, forKey: Constants.LOGIN_ISLOGGEDIN)
            UserDefaults.standard.set(self.text_email.text, forKey: Constants.LOGIN_EMAIL)
            UserDefaults.standard.set(self.text_password.text, forKey: Constants.LOGIN_PASSWORD)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(controller, animated: true, completion: nil)
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = controller
        }), onFailed: {error in
            self.hud.dismiss()
            self.showToast(message: error)
        })
    }
    
    @IBAction func onClickFacebook(_ sender: Any) {
        if let _ = AccessToken.current {
            // Access token available -- user already logged in
            // Perform log out
            
            self.getFBUserData()
            
        } else {
            let fbLoginManager = LoginManager()
            fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) -> Void in
                if (error == nil){
                    let fbloginresult : LoginManagerLoginResult = result!
                    if (result?.isCancelled)! {
                        return
                    }
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        self.getFBUserData()
                    }
                }
            }
        }
        
    }
    
    @IBAction func onClickGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickForgotPassword(_ sender: Any) {
        let controller = ForgotPasswordDialog.init(nibName: "ForgotPasswordDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func onClickAppleSignIn(_ sender: Any) {
        if #available(iOS 13.0, *) {
            processAppleSignin()
        }
    }
    
    @available(iOS 13.0, *)
    func processAppleSignin(){
        let provider = ASAuthorizationAppleIDProvider()
          let request = provider.createRequest()
          // request full name and email from the user's Apple ID
        request.requestedScopes = [.fullName, .email]

          // pass the request to the initializer of the controller
          let authController = ASAuthorizationController(authorizationRequests: [request])
        
          // similar to delegate, this will ask the view controller
          // which window to present the ASAuthorizationController
          authController.presentationContextProvider = self
        
          // delegate functions will be called when user data is
          // successfully retrieved or error occured
          authController.delegate = self
          
          // show the Sign-in with Apple dialog
          authController.performRequests()
    }
    
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            showToast(message: error.localizedDescription)
        } else {
            let givenName = user.profile.givenName!
            let familyName = user.profile.familyName!
            let email = user.profile.email!
            let photo = user.profile.hasImage ? user.profile.imageURL(withDimension: 100)?.absoluteString : ""
            self.hud.show(in: self.view)
            API.loginWithSocial(email: email, username: givenName + " " + familyName, photo_url: photo!, onSuccess: { response in
                self.hud.dismiss()
                AppData.user = response
                if AppData.user.sport > 500 {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
                    controller.modalPresentationStyle = .overFullScreen
                    controller.modalTransitionStyle = .crossDissolve
                    self.navigationController?.present(controller, animated: true, completion: nil)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "SignUpInfoViewController") as! SignUpInfoViewController
                    controller.email = AppData.user.email
                    controller.password = ""
                    controller.signup_mode = Constants.SIGNUP_SOCIAL
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                
            }, onFailed: { error in
                self.hud.dismiss()
                self.showToast(message: error)
            })
        }
    }
}

extension LoginViewController: GIDSignInUIDelegate {
}

extension LoginViewController: ForgotPasswordDialogDelegate {
    func onClickOk(email: String) {
        self.hud.show(in: self.view)
        API.forgotPassword(email: email, onSuccess: { response in
            self.hud.dismiss()
            self.showToast(message: "Success")
        }, onFailed: { error in
            self.hud.dismiss()
            self.showToast(message: error)
        })
    }
}

@available(iOS 13.0, *)
extension LoginViewController : ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            // For the purpose of this demo app, store the these details in the keychain. 
//            let userID = appleIDCredential.user
            // optional, might be nil
            let email = appleIDCredential.email
            // optional, might be nil
            let givenName = appleIDCredential.fullName?.givenName
            // optional, might be nil
            let familyName = appleIDCredential.fullName?.familyName
            // optional, might be nil
//            let nickName = appleIDCredential.fullName?.nickname
            
//            if let identityTokenData = appleIDCredential.identityToken,
//                let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
//                print("Identity Token \(identityTokenString)")
//            }
            if email != nil && givenName != nil {
                self.hud.show(in: self.view)
                API.loginWithSocial(email: email!, username: givenName! + " " + familyName!, photo_url: "avatar.png", onSuccess: { response in
                    self.hud.dismiss()
                    AppData.user = response
                    if AppData.user.sport > 500 {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
                        controller.modalPresentationStyle = .overFullScreen
                        controller.modalTransitionStyle = .crossDissolve
                        self.navigationController?.present(controller, animated: true, completion: nil)
                    } else {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpInfoViewController") as! SignUpInfoViewController
                        controller.email = AppData.user.email
                        controller.password = ""
                        controller.signup_mode = Constants.SIGNUP_SOCIAL
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    
                }, onFailed: { error in
                    self.hud.dismiss()
                    self.showToast(message: error)
                })
            }
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
//            let username = passwordCredential.user
//            let password = passwordCredential.password
        }
    }
}

@available(iOS 13.0, *)
extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

//
//  AlertDialogUtil.swift
//  Marifa
//
//  Created by tiexiong on 2/21/18.
//  Copyright © 2018 zhang. All rights reserved.
//

import Foundation
import JHTAlertController
import Toast_Swift

typealias JHTAlertActionHandler = ((JHTAlertAction) -> Void)?

extension UIViewController {
    func showJHTAlertOkayAction(message: String, action: JHTAlertActionHandler) {
        
        let alertController = JHTAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.titleViewBackgroundColor = .white
        alertController.titleTextColor = .black
        alertController.alertBackgroundColor = .white
        alertController.messageFont = UIFont(name: "VisbyRoundCF-Medium", size: 18)
        alertController.messageTextColor = .black
        alertController.setAllButtonBackgroundColors(to: .white)
        alertController.dividerColor = .black
        alertController.setButtonTextColorFor(.cancel, to: .black)
        alertController.hasRoundedCorners = true
        
        let cancelAction = JHTAlertAction(title: "OK", style: .cancel,  handler: action)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showJHTAlertWithOkayAndCancelAction(title: String, message: String, okayActionHandler: JHTAlertActionHandler, cancelActionHandler: JHTAlertActionHandler) {
        let alertController = JHTAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.titleViewBackgroundColor = .white
        alertController.titleTextColor = .black
        alertController.alertBackgroundColor = .white
        alertController.messageFont = UIFont(name: "VisbyRoundCF-Medium", size: 18)
        alertController.messageTextColor = .black
        alertController.setAllButtonBackgroundColors(to: .white)
        alertController.dividerColor = .black
        alertController.setButtonTextColorFor(.cancel, to: .black)
        alertController.setButtonTextColorFor(.default, to: .black)
        alertController.hasRoundedCorners = true
        
        let cancelAction = JHTAlertAction(title: "Cancel", style: .cancel,  handler: cancelActionHandler)
        let okayAction = JHTAlertAction(title: "Ok", style: .default,  handler: okayActionHandler)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showJHTAlertWithOkayAction(title: String, message: String, okayActionHandler: JHTAlertActionHandler) {
        let alertController = JHTAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.titleViewBackgroundColor = .white
        alertController.titleTextColor = .black
        alertController.alertBackgroundColor = .white
        alertController.messageFont = UIFont(name: "VisbyRoundCF-Medium", size: 18)
        alertController.messageTextColor = .black
        alertController.setAllButtonBackgroundColors(to: .white)
        alertController.dividerColor = .black
        alertController.setButtonTextColorFor(.default, to: .black)
        alertController.hasRoundedCorners = true
        
        let okayAction = JHTAlertAction(title: "Ok", style: .default,  handler: okayActionHandler)
        
        alertController.addAction(okayAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showJHTAlertWithOkayAndCancelAction(title: String, message: String, okString:String, cancelString:String, okayActionHandler: JHTAlertActionHandler, cancelActionHandler: JHTAlertActionHandler) {
        let alertController = JHTAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.titleViewBackgroundColor = .white
        alertController.titleTextColor = .black
        alertController.alertBackgroundColor = .white
        alertController.messageFont = UIFont(name: "VisbyRoundCF-Medium", size: 18)
        alertController.messageTextColor = .black
        alertController.setAllButtonBackgroundColors(to: .white)
        alertController.dividerColor = .black
        alertController.setButtonTextColorFor(.cancel, to: .black)
        alertController.setButtonTextColorFor(.default, to: .black)
        alertController.hasRoundedCorners = true
        
        let cancelAction = JHTAlertAction(title: cancelString, style: .cancel,  handler: cancelActionHandler)
        let okayAction = JHTAlertAction(title: okString, style: .default,  handler: okayActionHandler)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showJHTAlertWithTextField(title:String, placeholder:String, okayActionHandler:JHTAlertActionHandler, cancelActionHandler:JHTAlertActionHandler) {
        let alertController = JHTAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.titleViewBackgroundColor = .white
        alertController.titleTextColor = .black
        alertController.alertBackgroundColor = .white
        alertController.messageFont = UIFont(name: "VisbyRoundCF-Medium", size: 18)
        alertController.messageTextColor = .black
        alertController.setAllButtonBackgroundColors(to: .white)
        alertController.dividerColor = .black
        alertController.setButtonTextColorFor(.cancel, to: .black)
        alertController.setButtonTextColorFor(.default, to: .black)
        alertController.hasRoundedCorners = true

        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = placeholder
            textField.backgroundColor = .white
            textField.textColor = .black
            textField.keyboardType = .emailAddress
            textField.borderStyle = .roundedRect
            textField.font = UIFont(name: "VisbyRoundCF-Medium", size: 18)
        }
        
        let cancelAction = JHTAlertAction(title: "Later", style: .cancel,  handler: cancelActionHandler)
        let okayAction = JHTAlertAction(title: "Send", style: .default,  handler: okayActionHandler)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showToast(message: String) {
        self.view.makeToast(message)
    }
}

//
//  AddCareerDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

protocol AddCareerDialogDelegate {
    func onClickSubmit(club_name: String,
                       sport: String,
                       day: Int,
                       month: Int,
                       year: Int,
                       tday: Int,
                       tmonth: Int,
                       tyear: Int,
                       position: String,
                       location: String,
                       has_image: Bool,
                       logo: Data)
}

class AddCareerDialog: UIViewController {
    
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var view_club: UIView!
    @IBOutlet weak var text_club: UITextField!
    @IBOutlet weak var view_sport: UIView!
    @IBOutlet weak var text_sport: UITextField!
    @IBOutlet weak var view_year: UIView!
    @IBOutlet weak var text_year: UITextField!
    @IBOutlet weak var view_month: UIView!
    @IBOutlet weak var text_month: UITextField!
    @IBOutlet weak var view_day: UIView!
    @IBOutlet weak var text_day: UITextField!
    @IBOutlet weak var view_tyear: UIView!
    @IBOutlet weak var text_tyear: UITextField!
    @IBOutlet weak var view_tmonth: UIView!
    @IBOutlet weak var text_tmonth: UITextField!
    @IBOutlet weak var view_tday: UIView!
    @IBOutlet weak var text_tday: UITextField!
    @IBOutlet weak var view_position: UIView!
    @IBOutlet weak var text_position: UITextField!
    @IBOutlet weak var view_location: UIView!
    @IBOutlet weak var text_location: UITextField!
    @IBOutlet weak var btn_submit: UIButton!
    
    var delegate : AddCareerDialogDelegate!

    let picker = UIImagePickerController()
    var isUploadedLogo: Bool!
    var logo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self

        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true

        view_club.layer.cornerRadius = 9
        view_club.clipsToBounds = true
        view_sport.layer.cornerRadius = 9
        view_sport.clipsToBounds = true
        view_year.layer.cornerRadius = 9
        view_year.clipsToBounds = true
        view_month.layer.cornerRadius = 9
        view_month.clipsToBounds = true
        view_day.layer.cornerRadius = 9
        view_day.clipsToBounds = true
        view_tyear.layer.cornerRadius = 9
        view_tyear.clipsToBounds = true
        view_tmonth.layer.cornerRadius = 9
        view_tmonth.clipsToBounds = true
        view_tday.layer.cornerRadius = 9
        view_tday.clipsToBounds = true
        view_position.layer.cornerRadius = 9
        view_position.clipsToBounds = true
        view_location.layer.cornerRadius = 9
        view_location.clipsToBounds = true
        
        btn_submit.layer.cornerRadius = 4
        btn_submit.clipsToBounds = true
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickLogo(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        if (text_club.text?.isEmpty)! {
            self.showToast(message: "Please input club")
            return
        }
        if (text_sport.text?.isEmpty)! {
            self.showToast(message: "Please input sport")
            return
        }
        if (text_day.text?.isEmpty)! {
            self.showToast(message: "Please input day")
            return
        }
        if (text_month.text?.isEmpty)! {
            self.showToast(message: "Please input month")
            return
        }
        if (text_year.text?.isEmpty)! {
            self.showToast(message: "Please input year")
            return
        }
        if (text_tday.text?.isEmpty)! {
            text_tyear.text = ""
            text_tmonth.text = ""
        }
        if (text_tmonth.text?.isEmpty)! {
            text_tyear.text = ""
            text_tday.text = ""
        }
        if (text_tyear.text?.isEmpty)! {
            text_tmonth.text = ""
            text_tday.text = ""
        }
        if (text_position.text?.isEmpty)! {
            self.showToast(message: "Please input position")
            return
        }
        if (text_location.text?.isEmpty)! {
            self.showToast(message: "Please input location")
            return
        }
//        if isUploadedLogo == false {
//            self.showToast(message: "Please add image")
//            return
//        }
        
        let club_name = text_club.text!
        let sp_name = text_sport.text!
        let pos_name = text_position.text!
        let loc_name = text_location.text!
        
        let year = Int(text_year.text!)
        let month = Int(text_month.text!)
        let day = Int(text_day.text!)
        
        if isValidDate(year: year!, month: month!, day: day!) == false {
            self.showToast(message: "Invalid Date")
            return
        }
        
        let now = NSDate()
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let calendar = Calendar.current
        let birthday = calendar.date(from: dateComponents)
        let age = (now.timeIntervalSince1970 - (birthday?.timeIntervalSince1970)!)
        if age <= 0 {
            self.showToast(message: "Invalid Date")
        }
        
        var tyear = 0
        var tmonth = 0
        var tday = 0
        if text_tyear.text!.isEmpty == false {
            tyear = Int(text_tyear.text!)!
            tmonth = Int(text_tmonth.text!)!
            tday = Int(text_tday.text!)!
            if isValidDate(year: tyear, month: tmonth, day: tday) == false {
                self.showToast(message: "Invalid Date")
                return
            }
            
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day
            let tbirthday = calendar.date(from: dateComponents)
            let tage = (now.timeIntervalSince1970 - (tbirthday?.timeIntervalSince1970)!)
            if tage <= 0 {
                self.showToast(message: "Invalid Date")
                return
            }
        }
        
        self.actionBack(completion: {
            if self.delegate != nil {
                var cr_image : UIImage!
                if self.isUploadedLogo {
                    cr_image = Utils.resizeImage(image: self.logo, targetSize: CGSize(width: 200.0, height: 200.0))
                }
                self.delegate.onClickSubmit(club_name: club_name,
                                            sport: sp_name,
                                            day: day!,
                                            month: month!,
                                            year: year!,
                                            tday: tday,
                                            tmonth: tmonth,
                                            tyear: tyear,
                                            position: pos_name,
                                            location: loc_name,
                                            has_image: self.isUploadedLogo,
                                            logo: self.isUploadedLogo ? UIImagePNGRepresentation(cr_image)! : Data())
            }
        })
    }
}


extension AddCareerDialog: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.logo = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.isUploadedLogo = true
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

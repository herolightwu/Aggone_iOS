//
//  EditProfileViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/28/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import DropDown
import AVKit
import MobileCoreServices
import JGProgressHUD
import GooglePlaces

protocol EditProfileViewControllerDelegate {
    func updatedProfile()
}

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var image_avata: UIImageView!
    @IBOutlet weak var title_name: UILabel!
    @IBOutlet weak var title_city: UILabel!
    @IBOutlet weak var title_activity: UILabel!
    @IBOutlet weak var title_club: UILabel!
    @IBOutlet weak var title_sport: UILabel!
    @IBOutlet weak var title_specialty: UILabel!
    @IBOutlet weak var title_av_clubs: UILabel!
    @IBOutlet weak var title_category: UILabel!
    @IBOutlet weak var title_gender: UILabel!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_city: UILabel!
    @IBOutlet weak var label_category: UILabel!
    @IBOutlet weak var label_activity: UILabel!
    @IBOutlet weak var label_club: UILabel!
    @IBOutlet weak var label_age: UILabel!
    @IBOutlet weak var label_weight: UILabel!
    @IBOutlet weak var label_position: UILabel!
    @IBOutlet weak var label_specialty: UILabel!
    @IBOutlet weak var btn_apply: UIButton!
    @IBOutlet weak var btn_discard: UIButton!
    @IBOutlet weak var btn_available: UIButton!
    
    @IBOutlet weak var picker_view: UIPickerView!
    @IBOutlet weak var picker_height: UIPickerView!
    
    @IBOutlet weak var view_gender: UIView!
    @IBOutlet weak var btn_man: UIButton!
    @IBOutlet weak var btn_other: UIButton!
    @IBOutlet weak var btn_woman: UIButton!
    
    @IBOutlet weak var view_personal: UIView!
    @IBOutlet weak var totalHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextTopConstraint: NSLayoutConstraint!
    
    
    var sports: [Sport] = []
    var selectedSport: Int!
    
    var hud: JGProgressHUD!
    var user: User!
    
    var delegate: EditProfileViewControllerDelegate!

    let picker = UIImagePickerController()
    var isSelectedImage: Bool = false
    var photo: UIImage!
    
    var age: Int! = Constants.AGE_DEFAULT
    var type: Int! = Constants.PLAYER
    var height: Int! = Constants.HEIGHT_DEFAULT
    var weight: Int! = Constants.WEIGHT_DEFAULT
    var gender: Int! = Constants.GENDER_MAN
    var city: String! = ""
    var country: String! = ""
    var nAvailable:Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setViewController() {
        title_city.text = getString(key: "txt_city")
        title_club.text = getString(key: "club")
        title_gender.text = getString(key: "txt_gender")
        title_av_clubs.text = getString(key: "txt_available")
        title_category.text = getString(key: "category")
        title_specialty.text = getString(key: "txt_specialty")
        btn_man.setTitle(getString(key: "gender_man"), for: .normal)
        btn_woman.setTitle(getString(key: "gender_woman"), for: .normal)
        btn_other.setTitle(getString(key: "gender_other"), for: .normal)
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        picker_view.dataSource = self
        picker_view.delegate = self
        picker_height.dataSource = self
        picker_height.delegate = self
        
        picker.delegate = self
        
        image_avata.layer.cornerRadius = image_avata.bounds.height / 2
        image_avata.layer.borderWidth = 8
        image_avata.layer.borderColor = UIColor.from(hex: "#E4E4E4").cgColor
        image_avata.clipsToBounds = true
        image_avata.alpha = 0.8

        btn_apply.layer.cornerRadius = 7
        btn_apply.clipsToBounds = true
        btn_discard.layer.cornerRadius = 7
        btn_discard.layer.borderWidth = 2
        btn_discard.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_discard.clipsToBounds = true
        
        view_gender.layer.cornerRadius = 7
        view_gender.layer.borderWidth = 2
        view_gender.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        view_gender.clipsToBounds = true
        
        btn_man.layer.cornerRadius = 0
        btn_man.layer.borderWidth = 1
        btn_man.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_man.clipsToBounds = true
        
        btn_woman.layer.cornerRadius = 0
        btn_woman.layer.borderWidth = 1
        btn_woman.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_woman.clipsToBounds = true
        
        btn_other.layer.cornerRadius = 0
        btn_other.layer.borderWidth = 1
        btn_other.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_other.clipsToBounds = true
        
        setProfile()
    }
    
    func setProfile(){
        
        sports = getAllSports()
        var index: Int = 0
        for one in sports {
            if one.id == user.sport {
                break
            }
            index += 1
        }
        picker_view.selectRow(index, inComponent: 0, animated: false)
        selectedSport = user.sport
        
        if user.height > Constants.HEIGHT_MIN {
            picker_height.selectRow(user.height - Constants.HEIGHT_MIN, inComponent: 0, animated: false)
        } else {
            picker_height.selectRow(Constants.HEIGHT_DEFAULT - Constants.HEIGHT_MIN, inComponent: 0, animated: false)
        }
        
        nAvailable = user.available_club
        if user.available_club == 1{
            btn_available.setImage(UIImage(named: "ic_switch_on"), for: .normal)
        } else{
            btn_available.setImage(UIImage(named: "ic_switch_off"), for: .normal)
        }
        
        label_name.text = user.username
        label_category.text = user.category
        type = user.type
        switch type {
        case Constants.COACH:
            label_activity.text = getString(key: "coach")
        case Constants.TEAM_CLUB:
            label_activity.text = getString(key: "team_club")
        case Constants.AGENT:
            label_activity.text = getString(key: "agent")
        case Constants.STAFF:
            label_activity.text = getString(key: "staff")
        case Constants.COMPANY:
            label_activity.text = getString(key: "company")
        default:
            label_activity.text = getString(key: "player")
        }
        
        label_club.text = user.club
        label_position.text = user.position
        label_city.text = user.city
        label_age.text = "\(user.age)"
        label_weight.text = "\(user.weight)"
        label_specialty.text = user.contract
        
        if user.photo_url.isEmpty {
            image_avata.image = UIImage(named: "default_avata")
        } else {
            if user.photo_url.contains("http") {
                image_avata.sd_setImage(with: URL(string: user.photo_url), placeholderImage: nil)
            } else{
                image_avata.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + user.photo_url), placeholderImage: nil)
            }
        }
        
        age = user.age
        weight = user.weight
        height = user.height
        gender = user.gender
        city = user.city
        country = user.country
        
        refreshGender()
        refreshPersonalPanel()
    }
    
    func refreshPersonalPanel(){
        if type > Constants.COACH {
            view_personal.isHidden = true
            totalHeightConstraint.constant = 810
            nextTopConstraint.constant = 20
        } else{
            view_personal.isHidden = false
            totalHeightConstraint.constant = 1000
            nextTopConstraint.constant = 210
        }
    }
    
    func refreshGender(){
        switch gender {
        case Constants.GENDER_WOMAN:
            btn_woman.setTitleColor(UIColor.white, for: .normal)
            btn_woman.backgroundColor = UIColor.from(hex: "#82BF3F")
            btn_man.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_man.backgroundColor = UIColor.white
            btn_other.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_other.backgroundColor = UIColor.white
        case Constants.GENDER_OTHER:
            btn_other.setTitleColor(UIColor.white, for: .normal)
            btn_other.backgroundColor = UIColor.from(hex: "#82BF3F")
            btn_man.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_man.backgroundColor = UIColor.white
            btn_woman.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_woman.backgroundColor = UIColor.white
        default:
            btn_man.setTitleColor(UIColor.white, for: .normal)
            btn_man.backgroundColor = UIColor.from(hex: "#82BF3F")
            btn_woman.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_woman.backgroundColor = UIColor.white
            btn_other.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_other.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickCamera(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Add Photo", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .camera
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickName(_ sender: Any) {
        let controller = TextInputDialog.init(nibName: "TextInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.text = getString(key: "name")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickCity(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.addressComponents.rawValue))!
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteController.autocompleteFilter = filter
        autocompleteController.modalPresentationStyle = .overFullScreen
        autocompleteController.modalTransitionStyle = .crossDissolve
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func onClickCategory(_ sender: Any) {
        let controller = TextInputDialog.init(nibName: "TextInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.text = getString(key: "category")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickActivity(_ sender: Any) {
        let controller = ActivityDialog.init(nibName: "ActivityDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.type = type
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickClub(_ sender: Any) {
        let controller = TextInputDialog.init(nibName: "TextInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.text = getString(key: "club")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickAgeMinus(_ sender: Any) {
        if age > 0 { age -= 1 }
        label_age.text = "\(age!)"
    }
    
    @IBAction func onClickAgePlus(_ sender: Any) {
        age += 1
        label_age.text = "\(age!)"
    }
    
    @IBAction func onClickWeightMinus(_ sender: Any) {
        if weight > 0 { weight -= 1 }
        label_weight.text = "\(weight!)"
    }
    
    @IBAction func onClickWeightPlus(_ sender: Any) {
        weight += 1
        label_weight.text = "\(weight!)"
    }
    
    @IBAction func onClickPosition(_ sender: Any) {
        let controller = TextInputDialog.init(nibName: "TextInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.text = getString(key: "position")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickContract(_ sender: Any) {
        let controller = TextInputDialog.init(nibName: "TextInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.text = getString(key: "specialty")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickApply(_ sender: Any) {
        if (label_name.text?.isEmpty)! {
            showToast(message: "Please input name")
            return
        }
        let new_user: User = user
        new_user.username = label_name.text!
        new_user.category = label_category.text!
        new_user.club = label_club.text!
        new_user.type = self.type
        new_user.sport = selectedSport
        new_user.position = label_position.text!
        new_user.city = city
        new_user.country = country
        new_user.contract = label_specialty.text!
        new_user.age = age
        new_user.weight = weight
        new_user.height = height
        
        if isSelectedImage {
            let file_name:String = "photo_" + AppData.user.id + "\(UInt(Date().timeIntervalSince1970))"
            let user_image = Utils.resizeImage(image: self.photo, targetSize: CGSize(width: 200.0, height: 200.0))
            hud.show(in: view)
            API.uploadImage(name: file_name, image: UIImagePNGRepresentation(user_image)!, onSuccess: { response in
                new_user.photo_url = response
                self.updateProfile(user: new_user)
                self.hud.dismiss()
            }, onFailed: { error in
                self.hud.dismiss()
                self.showToast(message: error)
            })
        } else {
            updateProfile(user: new_user)
        }
    }
    
    func updateProfile(user: User) {
        hud.show(in: view)
        API.updateUser(user: user, onSuccess: { response in
            AppData.user = response
            self.hud.dismiss()
            self.actionBack(completion: {
                if self.delegate != nil {
                    self.delegate.updatedProfile()
                }
            })
        }, onFailed: { error in
            self.hud.dismiss()
            self.showToast(message: error)
        })
    }
    
    @IBAction func onClickAvailable(_ sender: Any) {
        if nAvailable == 1 {
            nAvailable = 0
        } else{
            nAvailable = 1
        }
        hud.show(in: view)
        API.updateUserFields(fieldname: "available_club", fieldvalue: "\(nAvailable!)", onSuccess: { response in
            self.hud.dismiss()
            AppData.user = response
//            self.nAvailable = AppData.user.available_club
            self.user = AppData.user
            self.setProfile()
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }
    
    @IBAction func onClickDiscard(_ sender: Any) {
        actionBack()
    }
    
    @IBAction func onClickWoman(_ sender: Any) {
        gender = Constants.GENDER_WOMAN
        refreshGender()
    }
    
    @IBAction func onClickMan(_ sender: Any) {
        gender = Constants.GENDER_MAN
        refreshGender()
    }
    
    @IBAction func onClickOther(_ sender: Any) {
        gender = Constants.GENDER_OTHER
        refreshGender()
    }
    
    func refreshCity(){
        label_city.text = city
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.image_avata.image = self.photo
        self.isSelectedImage = true
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController: TextInputDialogDelegate {
    func onClickOk(text: String, value: String) {
        if text == getString(key: "name") {
            label_name.text = value
        } else if text == getString(key: "category") {
            label_category.text = value
        } else if text == getString(key: "club") {
            label_club.text = value
        } else if text == getString(key: "position") {
            label_position.text = value
        } else if text == getString(key: "specialty") {
            label_specialty.text = value
        }
    }
}

extension EditProfileViewController: ActivityDialogDelegate {
    func onSelectActivity(type: Int) {
        self.type = type
        switch type {
        case Constants.COACH:
            label_activity.text = getString(key: "coach")
        case Constants.TEAM_CLUB:
            label_activity.text = getString(key: "team_club")
        case Constants.AGENT:
            label_activity.text = getString(key: "agent")
        case Constants.STAFF:
            label_activity.text = getString(key: "staff")
        case Constants.COMPANY:
            label_activity.text = getString(key: "company")
        default:
            label_activity.text = getString(key: "player")
        }
        refreshPersonalPanel()
    }
}

extension EditProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker_view {
            return sports.count
        } else if pickerView == picker_height {
            return Constants.HEIGHT_MAX - Constants.HEIGHT_MIN
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker_view {
            return sports[row].name
        } else if pickerView == picker_height {
            return "\(Constants.HEIGHT_MIN + row)"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if pickerView == picker_view {
            return 30
        } else if pickerView == picker_height {
            return 16
        }
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker_view {
            selectedSport = sports[row].id
        } else if pickerView == picker_height {
            height = Constants.HEIGHT_MIN + row
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == picker_height {
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Helvetica Neue", size: 11)
    //data source means your ui picker view items array
            label.text = "\(Constants.HEIGHT_MIN + row)"
            label.textAlignment = .right
            return label
        } else { //if pickerView == picker_view
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Helvetica Neue", size: 20)
            label.text = sports[row].name
            label.textAlignment = .center
            return label
        }
    }
}

extension EditProfileViewController:SwiftySwitchDelegate{
    func valueChanged(sender: SwiftySwitch) {
        if sender.isOn {
            API.updateUserFields(fieldname: "available_club", fieldvalue: "1", onSuccess: { response in
                AppData.user = response
            }, onFailed: { err in
                self.showToast(message: err)
            })
        } else {
            API.updateUserFields(fieldname: "available_club", fieldvalue: "0", onSuccess: { response in
                AppData.user = response
            }, onFailed: { err in
                self.showToast(message: err)
            })
        }
    }
}

extension EditProfileViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    city  = place.name
    if let addressComponents = place.addressComponents,let countryComponent = (addressComponents.filter { $0.type == "country" }.first) {
      country = countryComponent.name
    }
    dismiss(animated: true, completion: nil)
    self.refreshCity()
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}

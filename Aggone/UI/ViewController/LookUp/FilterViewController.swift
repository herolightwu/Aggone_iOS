//
//  FilterViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/22/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD
import GooglePlaces

class FilterViewController: UIViewController {

    @IBOutlet weak var img_player: UIImageView!
    @IBOutlet weak var img_coach: UIImageView!
    @IBOutlet var text_name: UITextField!
    @IBOutlet var label_age: UILabel!
    @IBOutlet var label_height: UILabel!
    @IBOutlet var label_weight: UILabel!
    @IBOutlet weak var btn_search: UIButton!
    @IBOutlet weak var btn_reset: UIButton!
    
    @IBOutlet weak var lb_gender: UILabel!
    @IBOutlet weak var ch_gender_man: ImageCheckBox!
    @IBOutlet weak var lb_man: UILabel!
    @IBOutlet weak var ch_gender_woman: ImageCheckBox!
    @IBOutlet weak var lb_woman: UILabel!
    @IBOutlet weak var ch_gender_other: ImageCheckBox!
    @IBOutlet weak var lb_other: UILabel!
    //Group
    @IBOutlet weak var lb_player: UILabel!
    @IBOutlet weak var lb_coach: UILabel!
    @IBOutlet weak var lb_club: UILabel!
    @IBOutlet weak var lb_agent: UILabel!
    @IBOutlet weak var lb_staff: UILabel!
    @IBOutlet weak var lb_company: UILabel!
    @IBOutlet weak var img_club: UIImageView!
    @IBOutlet weak var img_agent: UIImageView!
    @IBOutlet weak var img_staff: UIImageView!
    @IBOutlet weak var img_company: UIImageView!
    //City
    @IBOutlet weak var btn_city: UIButton!
    @IBOutlet weak var lb_country: UILabel!
    @IBOutlet weak var img_flag: UIImageView!
    @IBOutlet weak var btn_country: UILabel!
    
    @IBOutlet weak var personal_view: UIView!
    @IBOutlet weak var country_view: UIView!
    
    @IBOutlet weak var constraint_height: NSLayoutConstraint!
    @IBOutlet weak var picker_view: UIPickerView!
    var sports:[Sport] = []
    var users:[User] = []
    
    var selectedGroup: Int! = Constants.PLAYER
    var selectedSport: Int! = Constants.Football
    var age: Int! = Constants.AGE_DEFAULT
    var height: Int! = Constants.HEIGHT_DEFAULT
    var weight: Int! = Constants.WEIGHT_DEFAULT
    var gender: Int! = Constants.GENDER_MAN
    
    var city: String! = ""
    var country: String! = ""
    
    var hud: JGProgressHUD!
    
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
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        sports = getAllSports()
        picker_view.dataSource = self
        picker_view.delegate = self
        
        picker_view.selectRow(0, inComponent: 0, animated: true)
        selectedSport = sports[0].id
        
        btn_search.layer.cornerRadius = 10
        btn_search.clipsToBounds = true
        btn_reset.layer.cornerRadius = 10
        btn_reset.layer.borderWidth = 2
        btn_reset.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_reset.clipsToBounds = true
        
        label_age.text = "\(age!)"
        label_weight.text = "\(weight!)"
        label_height.text = "\(height!)"
        
        lb_gender.text = getString(key: "txt_gender")
        lb_country.text = getString(key: "txt_country")
        lb_man.text = getString(key: "gender_man")
        lb_woman.text = getString(key: "gender_woman")
        lb_other.text = getString(key: "gender_other")
        lb_player.text = getString(key: "player")
        lb_coach.text = getString(key: "coach")
        lb_club.text = getString(key: "team_club")
        lb_agent.text = getString(key: "agent")
        lb_staff.text = getString(key: "staff")
        lb_company.text = getString(key: "company")
        
        refreshView()
    }
    
    func refreshView(){
        if selectedGroup == Constants.PLAYER{
            personal_view.isHidden = false
            country_view.isHidden = true
            constraint_height.constant = 760.0
        } else{
            country_view.isHidden = false
            personal_view.isHidden = true
            constraint_height.constant = 670
        }
        switch gender {
        case Constants.GENDER_MAN:
            ch_gender_man.isChecked = true
            ch_gender_woman.isChecked = false
            ch_gender_other.isChecked = false
        case Constants.GENDER_WOMAN:
            ch_gender_man.isChecked = false
            ch_gender_woman.isChecked = true
            ch_gender_other.isChecked = false
        default:
            ch_gender_man.isChecked = false
            ch_gender_woman.isChecked = false
            ch_gender_other.isChecked = true
        }
        
        switch selectedGroup {
        case Constants.COACH:
            img_player.image = UIImage(named: "auth_player_normal")
            img_coach.image = UIImage(named: "auth_coach_active")
            img_club.image = UIImage(named: "auth_club_normal")
            img_agent.image = UIImage(named: "auth_agent_normal")
            img_staff.image = UIImage(named: "auth_staff_normal")
            img_company.image = UIImage(named: "auth_company_normal")
        case Constants.TEAM_CLUB:
            img_player.image = UIImage(named: "auth_player_normal")
            img_coach.image = UIImage(named: "auth_coach_normal")
            img_club.image = UIImage(named: "auth_club_active")
            img_agent.image = UIImage(named: "auth_agent_normal")
            img_staff.image = UIImage(named: "auth_staff_normal")
            img_company.image = UIImage(named: "auth_company_normal")
        case Constants.AGENT:
            img_player.image = UIImage(named: "auth_player_normal")
            img_coach.image = UIImage(named: "auth_coach_normal")
            img_club.image = UIImage(named: "auth_club_normal")
            img_agent.image = UIImage(named: "auth_agent_active")
            img_staff.image = UIImage(named: "auth_staff_normal")
            img_company.image = UIImage(named: "auth_company_normal")
        case Constants.STAFF:
            img_player.image = UIImage(named: "auth_player_normal")
            img_coach.image = UIImage(named: "auth_coach_normal")
            img_club.image = UIImage(named: "auth_club_normal")
            img_agent.image = UIImage(named: "auth_agent_normal")
            img_staff.image = UIImage(named: "auth_staff_active")
            img_company.image = UIImage(named: "auth_company_normal")
        case Constants.COMPANY:
            img_player.image = UIImage(named: "auth_player_normal")
            img_coach.image = UIImage(named: "auth_coach_normal")
            img_club.image = UIImage(named: "auth_club_normal")
            img_agent.image = UIImage(named: "auth_agent_normal")
            img_staff.image = UIImage(named: "auth_staff_normal")
            img_company.image = UIImage(named: "auth_company_active")
        default:
            img_player.image = UIImage(named: "auth_player_active")
            img_coach.image = UIImage(named: "auth_coach_normal")
            img_club.image = UIImage(named: "auth_club_normal")
            img_agent.image = UIImage(named: "auth_agent_normal")
            img_staff.image = UIImage(named: "auth_staff_normal")
            img_company.image = UIImage(named: "auth_company_normal")
        }
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        hud.show(in: view)
        API.getUserByFilter(sport: selectedSport, gender: gender, type: selectedGroup, name: text_name.text!, city: city, country: country, age: age, height: height, weight: weight, onSuccess: { response in
            self.hud.dismiss()
            if response.count > 0 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "FilterResultViewController") as! FilterResultViewController
                controller.list_users = response
                self.navigationController?.pushViewController(controller, animated: true)
            } else{
                self.showToast(message: "No Result")
            }
            
        }, onFailed: { error in
            self.hud.dismiss()
            self.showToast(message: error)
        })
    }
    
    @IBAction func onClickReset(_ sender: Any) {
        selectedSport = Constants.Football
        selectedGroup = Constants.PLAYER
        gender = Constants.GENDER_MAN
        
        age = Constants.AGE_DEFAULT
        weight = Constants.WEIGHT_DEFAULT
        height = Constants.HEIGHT_DEFAULT
        label_age.text = "\(age!)"
        label_weight.text = "\(weight!)"
        label_height.text = "\(height!)"
        
        text_name.text = ""
        city = ""
        country = ""
        btn_city.setTitle(city, for: .normal)
        btn_country.text = country
        img_flag.image = nil
        
        refreshView()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickPlayer(_ sender: Any) {
        selectedGroup = Constants.PLAYER
        refreshView()
    }
    
    @IBAction func onClickCoach(_ sender: Any) {
        selectedGroup = Constants.COACH
        refreshView()
    }
    @IBAction func onClickClub(_ sender: Any) {
        selectedGroup = Constants.TEAM_CLUB
        refreshView()
    }
    @IBAction func onClickAgent(_ sender: Any) {
        selectedGroup = Constants.AGENT
        refreshView()
    }
    
    @IBAction func onClickAgeMinus(_ sender: Any) {
        if age > Constants.AGE_MIN { age -= 1 }
        label_age.text = "\(age!)"
    }
    @IBAction func onClickStaff(_ sender: Any) {
        selectedGroup = Constants.STAFF
        refreshView()
    }
    @IBAction func onClickCompany(_ sender: Any) {
        selectedGroup = Constants.COMPANY
        refreshView()
    }
    
    @IBAction func onClickAgePlus(_ sender: Any) {
        if age < Constants.AGE_MAX {age += 1}
        label_age.text = "\(age!)"
    }
    
    @IBAction func onClickWeightMinus(_ sender: Any) {
        if weight > Constants.WEIGHT_MIN { weight -= 1 }
        label_weight.text = "\(weight!)"
    }
    
    @IBAction func onClickWeightPlus(_ sender: Any) {
        if weight < Constants.WEIGHT_MAX { weight += 1 }
        label_weight.text = "\(weight!)"
    }
    
    @IBAction func onClickHeightMinus(_ sender: Any) {
        if height > Constants.HEIGHT_MIN { height -= 1 }
        label_height.text = "\(height!)"
    }
    
    @IBAction func onClickHeightPlus(_ sender: Any) {
        if height < Constants.HEIGHT_MAX { height += 1 }
        label_height.text = "\(height!)"
    }
    
    @IBAction func onClickMan(_ sender: Any) {
        gender = Constants.GENDER_MAN
        refreshView()
    }
    @IBAction func onClickWoman(_ sender: Any) {
        gender = Constants.GENDER_WOMAN
        refreshView()
    }
    
    @IBAction func onClickOther(_ sender: Any) {
        gender = Constants.GENDER_OTHER
        refreshView()
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
    func refreshCity(){
        btn_city.setTitle(city, for: .normal)
        lb_country.text = country
        var country_str = locale_en(for:country)
        if country_str.isEmpty {
            country_str = country
        }
        let ccode = IsoCountryCodes.find(key:country_str)
        if ccode != nil && !ccode!.alpha2.isEmpty {
            img_flag.image = getCountryFlag(countryCode: ccode!.alpha2)
        }
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sports[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSport = sports[row].id
    }
}

extension FilterViewController: GMSAutocompleteViewControllerDelegate {

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

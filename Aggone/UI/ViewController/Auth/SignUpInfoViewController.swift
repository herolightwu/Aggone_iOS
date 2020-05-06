//
//  SignUpInfoViewController.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/8/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import GooglePlaces
import DropDown

class SignUpInfoViewController: UIViewController {

    @IBOutlet var text_name: UITextField!
    @IBOutlet var text_day: UITextField!
    @IBOutlet var text_month: UITextField!
    @IBOutlet var text_year: UITextField!
    @IBOutlet weak var btn_city: UIButton!
    @IBOutlet weak var lb_country: UILabel!
    @IBOutlet weak var img_flag: UIImageView!
    @IBOutlet weak var gender_view: UIButton!
    
    var email: String!
    var password: String!
    var signup_mode : Int = Constants.SIGNUP_EMAIL
    
    var city: String! = "Paris"
    var country: String! = "France"
    var gender : Int = Constants.GENDER_MAN
    var dd_gener : DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gender_view.setTitle(getString(key: "gender_man"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        
        var country_str = locale_en(for:country)
        if country_str.isEmpty {
            country_str = country
        }
        let ccode = IsoCountryCodes.find(key: country_str)
        if ccode != nil && !ccode!.alpha2.isEmpty {
            img_flag.image = getCountryFlag(countryCode: ccode!.alpha2)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickGender(_ sender: Any) {
        dd_gener = DropDown()
        dd_gener.anchorView = gender_view
        dd_gener.direction = .any
        dd_gener.localizationKeysDataSource = ["gender_man", "gender_woman", "gender_other"]
        dd_gener.selectionAction = { [unowned self] (index: Int, item: String) in
            self.gender = index
            self.gender_view.setTitle(item, for: .normal)
        }
        dd_gener.show()
    }
    @IBAction func onClickRegister(_ sender: Any) {
        let name = text_name.text
        let year_str = text_year.text
        let month_str = text_month.text
        let day_str = text_day.text
        if (name?.isEmpty)! {
            showToast(message: "Please input name")
            return
        }
        if city.isEmpty {
            showToast(message: "Please select city")
            return
        }
        if country.isEmpty {
            showToast(message: "Please select country")
            return
        }
        let year = Int(year_str ?? "0") ?? 0
        let month = Int(month_str ?? "0") ?? 0
        let day = Int(day_str ?? "0") ?? 0
        
        let now = NSDate()
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let calendar = Calendar.current
        let birthday = calendar.date(from: dateComponents)
        var age = (now.timeIntervalSince1970 - (birthday?.timeIntervalSince1970)!) / 60 / 60 / 24 / 365
        
        if age > 100 {
            age = 0
        }
        
        if signup_mode == Constants.SIGNUP_EMAIL {
            let user = User()
            user.username = name!
            user.city = city
            user.country = country
            user.gender = gender
            user.year = year
            user.month = month
            user.day = day
            user.age = Int(age)
            AppData.user = user
        } else {
            AppData.user.username = name!
            AppData.user.year = year
            AppData.user.month = month
            AppData.user.day = day
            AppData.user.age = Int(age)
            AppData.user.city = city
            AppData.user.country = country
            AppData.user.gender = gender;
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterDetailsViewController") as! RegisterDetailsViewController
        controller.email = email
        controller.password = password
        controller.signup_mode = signup_mode
        self.navigationController?.pushViewController(controller, animated: true)
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
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func refreshView(){
        btn_city.setTitle(city, for: .normal)
        lb_country.text = country
        var country_str = locale_en(for:country)
        if country_str.isEmpty {
            country_str = country
        }
        let fullname = IsoCountryCodes.find(key: country_str)
        if fullname != nil && !fullname!.alpha2.isEmpty {
            img_flag.image = getCountryFlag(countryCode: fullname!.alpha2)
        }
    }
    
}

extension SignUpInfoViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    city  = place.name
    if let addressComponents = place.addressComponents,let countryComponent = (addressComponents.filter { $0.type == "country" }.first) {
      country = countryComponent.name
    }
    dismiss(animated: true, completion: nil)
    self.refreshView()
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

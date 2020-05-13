//
//  CreateAdmobViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/24/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
import JGProgressHUD
import GooglePlaces

class CreateAdmobViewController: UIViewController {
    
    @IBOutlet var text_description: UITextView!
    @IBOutlet weak var btn_city: UIButton!
    @IBOutlet weak var btn_country: UILabel!
    @IBOutlet weak var img_flag: UIImageView!
    
    @IBOutlet weak var btn_send: UIButton!
    @IBOutlet weak var btn_reset: UIButton!
    
    @IBOutlet weak var picker_view: UIPickerView!
    var sports: [Sport] = []
    var selectedSport: Int!
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
    
    func setViewController() {
        btn_send.layer.cornerRadius = 10
        btn_send.clipsToBounds = true
        
        btn_reset.layer.cornerRadius = 10
        btn_reset.layer.borderWidth = 2
        btn_reset.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_reset.clipsToBounds = true
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        sports = getAllSports()
        picker_view.dataSource = self
        picker_view.delegate = self
        
        picker_view.selectRow(0, inComponent: 0, animated: false)
        selectedSport = sports[0].id
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSend(_ sender: Any) {
        if city.isEmpty {
            showToast(message: "Please choose city")
            return
        }
        if country.isEmpty {
            showToast(message: "Please choose city again")
            return
        }
        if (text_description.text?.isEmpty)! {
            showToast(message: "Please input description")
            return
        }
        
        let admob = Admob()
        admob.user = AppData.user
        admob.city = city
        admob.position = country
        admob.description = text_description.text!
        admob.sport = selectedSport
        
        hud.show(in: view)
        API.saveAdmob(admob: admob, onSuccess: { response in
            self.hud.dismiss()
            self.actionBack()
        }, onFailed: { error in
            self.hud.dismiss()
            self.showToast(message: error)
        })
    }
    
    @IBAction func onClickReset(_ sender: Any) {
        city = ""
        country = ""
        selectedSport = Constants.Football
        btn_city.setTitle("", for: .normal)
        text_description.text = ""
        btn_country.text = ""
        img_flag.image = nil
        picker_view.selectRow(0, inComponent: 0, animated: true)
        selectedSport = sports[0].id
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
    func refreshView(){
        btn_city.setTitle(city, for: .normal)
        btn_country.text = country
        
        var country_str = locale_en(for:country)
        if country_str.isEmpty {
            country_str = country
        }
        let ccode = IsoCountryCodes.find(key: country_str)
        if ccode != nil && !ccode!.alpha2.isEmpty {
            img_flag.image = getCountryFlag(countryCode: ccode!.alpha2)
        }
    }
}

extension CreateAdmobViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension CreateAdmobViewController: GMSAutocompleteViewControllerDelegate {

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

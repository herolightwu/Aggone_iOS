//
//  LookingClubViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/24/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import GooglePlaces

class LookingClubViewController: UIViewController {
   
    @IBOutlet weak var lb_sport: UILabel!
    @IBOutlet weak var lb_city: UILabel!
    @IBOutlet weak var btn_city: UIButton!
    @IBOutlet weak var pv_sport: UIPickerView!
    @IBOutlet weak var lb_country: UILabel!
    @IBOutlet weak var img_flag: UIImageView!
    @IBOutlet weak var btn_country: UILabel!
    @IBOutlet weak var btn_reset: UIButton!
    @IBOutlet weak var btn_apply: UIButton!
    
    @IBOutlet var table_view: UITableView!
    let refreshControl = UIRefreshControl()
    
    var admobs: [Admob] = []
    var sports: [Sport] = []
    var selectedSport: Int!
    var city: String! = ""
    var country: String! = ""
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        btn_reset.setTitle(getString(key: "reset"), for: .normal)
        btn_apply.setTitle(getString(key: "apply"), for: .normal)
        lb_sport.text = getString(key: "txt_sport")
        lb_city.text = getString(key: "txt_city")
        lb_country.text = getString(key: "txt_country")
    }

    func setViewController() {
        sports = getAllSports()
        pv_sport.dataSource = self
        pv_sport.delegate = self
        
        let index: Int = 0
        pv_sport.selectRow(index, inComponent: 0, animated: false)
        selectedSport = Constants.Football
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        table_view.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    @objc func refresh() {
        API.filterAdmobs(sport: selectedSport, city: city, country: country, onSuccess: {response in
            self.admobs = response
            self.table_view.reloadData()
            self.refreshControl.endRefreshing()
        }, onFailed: { err in
            self.showToast(message: err)
            self.refreshControl.endRefreshing()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshView(){
        btn_city.setTitle(city, for: .normal)
        btn_country.text = country
        
        var country_str = locale_en(for:country)
        if country_str.isEmpty {
            country_str = country
        }
        let ccode = IsoCountryCodes.find(key:country_str)
        if ccode != nil && !ccode!.alpha2.isEmpty {
            img_flag.image = getCountryFlag(countryCode: ccode!.alpha2)
        }
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
    
    @IBAction func onClickReset(_ sender: Any) {
        city = ""
        country = ""
        selectedSport = Constants.Football
        btn_city.setTitle("", for: .normal)
        btn_country.text = ""
        img_flag.image = nil
        pv_sport.selectRow(0, inComponent: 0, animated: false)
        admobs.removeAll()
        table_view.reloadData()
    }
    
    @IBAction func onClickApply(_ sender: Any) {
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    @IBAction func onClickLookup(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickMain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickStats(_ sender: Any) {
        if AppData.user.type == Constants.TEAM_CLUB || AppData.user.type == Constants.STAFF {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ClubChartVC") as! ClubChartVC
            controller.user = AppData.user
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "StatsViewController") as! StatsViewController
            controller.user = AppData.user
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func onClickChats(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension LookingClubViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return admobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LookingClubTableViewCell", for: indexPath) as! LookingClubTableViewCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(admob: admobs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = admobs[indexPath.row].user
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension LookingClubViewController: LookingClubCellDelegates {
}

extension LookingClubViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension LookingClubViewController: GMSAutocompleteViewControllerDelegate {

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

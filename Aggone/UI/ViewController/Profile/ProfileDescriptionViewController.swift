//
//  ProfileDescriptionViewController.swift
//  Aggone
//
//  Created by tiexiong on 3/21/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import Charts

class ProfileDescriptionViewController: UIViewController {

    @IBOutlet weak var label_height: UILabel!
    @IBOutlet weak var label_weight: UILabel!
    @IBOutlet weak var label_age: UILabel!
    @IBOutlet weak var label_position: UILabel!
    @IBOutlet weak var img_flag: UIImageView!
    
    @IBOutlet weak var lb_tt_position: UILabel!
    @IBOutlet weak var lb_tt_country: UILabel!
        
    @IBOutlet weak var btn_access: UIButton!
    @IBOutlet weak var label_access: UILabel!
    
    @IBOutlet weak var radar_skills: RadarChartView!
    @IBOutlet weak var radar_individual_technique: RadarChartView!
    @IBOutlet weak var radar_physical_quantities: RadarChartView!
    @IBOutlet weak var radar_tactics: RadarChartView!
    
    @IBOutlet weak var label_skill1: UILabel!
    @IBOutlet weak var label_skill2: UILabel!
    @IBOutlet weak var label_skill3: UILabel!
    @IBOutlet weak var label_skill4: UILabel!    
    
    var user: User!
    var listSkills: [Description] = []
    var listIndividualTechnique: [Description] = []
    var listPhysicalQuantities: [Description] = []
    var listTactics: [Description] = []
    var parentVC: ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }

    @IBAction func onClickAccess(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EditDescriptionViewController") as! EditDescriptionViewController
        controller.user = user
        present(controller, animated: true, completion: nil)
    }
    
    func setViewController() {
        lb_tt_country.text = getString(key: "txt_country")
        lb_tt_position.text = getString(key: "position")
        if user.id == AppData.user.id {
            btn_access.isHidden = true
            label_access.isHidden = true
        } else {
            btn_access.isHidden = false
            label_access.isHidden = false
        }
        label_age.text = "\(user.age)"
        label_weight.text = "\(user.weight)"
        label_height.text = "\(user.height)"
        label_position.text = user.contract
        
        var country_str = locale_en(for:user.country)
        if country_str.isEmpty {
            country_str = user.country
        }
        let fullname = IsoCountryCodes.find(key: country_str)
        if fullname != nil && !fullname!.alpha2.isEmpty {
            img_flag.image = getCountryFlag(countryCode: fullname!.alpha2)
        }

        if user.type == Constants.PLAYER {
            label_skill1.text = getString(key: "category_1")
            label_skill2.text = getString(key: "category_2")
            label_skill3.text = getString(key: "category_3")
            label_skill4.text = getString(key: "category_4")
        } else {
            label_skill1.text = getString(key: "ccategory_1")
            label_skill2.text = getString(key: "ccategory_2")
            label_skill3.text = getString(key: "ccategory_3")
            label_skill4.text = getString(key: "ccategory_4")
        }
        loadDescription()
    }
    
    func loadDescription() {
        API.getAllDescriptionsByUserid(user_id: user.id, onSuccess: { response in
            if self.user.type == Constants.PLAYER {
                var ids: [Int] = [
                    Constants.DESCRIPTION1,
                    Constants.DESCRIPTION2,
                    Constants.DESCRIPTION3,
                    Constants.DESCRIPTION4,
                    Constants.DESCRIPTION5,
                    Constants.DESCRIPTION6]
                self.listSkills = self.getDescriptions(user_id: self.user.id, ids: ids, descriptions: response)
                
                ids = [
                    Constants.DESCRIPTION7,
                    Constants.DESCRIPTION8,
                    Constants.DESCRIPTION9,
                    Constants.DESCRIPTION10,
                    Constants.DESCRIPTION11,
                    Constants.DESCRIPTION12]
                self.listIndividualTechnique = self.getDescriptions(user_id: self.user.id, ids: ids, descriptions: response)
                
                ids = [
                    Constants.DESCRIPTION13,
                    Constants.DESCRIPTION14,
                    Constants.DESCRIPTION15,
                    Constants.DESCRIPTION16,
                    Constants.DESCRIPTION17,
                    Constants.DESCRIPTION18]
                self.listPhysicalQuantities = self.getDescriptions(user_id: self.user.id, ids: ids, descriptions: response)
                
                ids = [
                    Constants.DESCRIPTION19,
                    Constants.DESCRIPTION20,
                    Constants.DESCRIPTION21,
                    Constants.DESCRIPTION22,
                    Constants.DESCRIPTION23,
                    Constants.DESCRIPTION24]
                self.listTactics = self.getDescriptions(user_id: self.user.id, ids: ids, descriptions: response)
            } else {
                var ids: [Int] = [
                    Constants.CDESCRIPTION1,
                    Constants.CDESCRIPTION2,
                    Constants.CDESCRIPTION3,
                    Constants.CDESCRIPTION4,
                    Constants.CDESCRIPTION5,
                    Constants.CDESCRIPTION6]
                self.listSkills = self.getDescriptions(user_id: self.user.id, ids: ids, descriptions: response)
                
                ids = [
                    Constants.CDESCRIPTION7,
                    Constants.CDESCRIPTION8,
                    Constants.CDESCRIPTION9,
                    Constants.CDESCRIPTION10,
                    Constants.CDESCRIPTION11,
                    Constants.CDESCRIPTION12]
                self.listIndividualTechnique = self.getDescriptions(user_id: self.user.id, ids: ids, descriptions: response)
                
                ids = [
                    Constants.CDESCRIPTION13,
                    Constants.CDESCRIPTION14,
                    Constants.CDESCRIPTION15,
                    Constants.CDESCRIPTION16,
                    Constants.CDESCRIPTION17,
                    Constants.CDESCRIPTION18]
                self.listPhysicalQuantities = self.getDescriptions(user_id: self.user.id, ids: ids, descriptions: response)
                
                ids = [
                    Constants.CDESCRIPTION19,
                    Constants.CDESCRIPTION20,
                    Constants.CDESCRIPTION21,
                    Constants.CDESCRIPTION22,
                    Constants.CDESCRIPTION23,
                    Constants.CDESCRIPTION24]
                self.listTactics = self.getDescriptions(user_id: self.user.id, ids: ids, descriptions: response)
            }
            self.setChart()
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
    
    var skillLabels: [String] = []
    var individualLabels: [String] = []
    var physicalLabels: [String] = []
    var tacticsLabels: [String] = []
    
    func setChart() {
        if user.type == Constants.PLAYER {
            skillLabels = [
                getString(key: "description_1"),
                getString(key: "description_2"),
                getString(key: "description_3"),
                getString(key: "description_4"),
                getString(key: "description_5"),
                getString(key: "description_6"),
            ]
            individualLabels = [
                getString(key: "description_7"),
                getString(key: "description_8"),
                getString(key: "description_9"),
                getString(key: "description_10"),
                getString(key: "description_11"),
                getString(key: "description_12"),
            ]
            physicalLabels = [
                getString(key: "description_13"),
                getString(key: "description_14"),
                getString(key: "description_15"),
                getString(key: "description_16"),
                getString(key: "description_17"),
                getString(key: "description_18"),
            ]
            tacticsLabels = [
                getString(key: "description_19"),
                getString(key: "description_20"),
                getString(key: "description_21"),
                getString(key: "description_22"),
                getString(key: "description_23"),
                getString(key: "description_24"),
            ]
        } else {
            skillLabels = [
                getString(key: "cdescription_1"),
                getString(key: "cdescription_2"),
                getString(key: "cdescription_3"),
                getString(key: "cdescription_4"),
                getString(key: "cdescription_5"),
                getString(key: "cdescription_6"),
            ]
            individualLabels = [
                getString(key: "cdescription_7"),
                getString(key: "cdescription_8"),
                getString(key: "cdescription_9"),
                getString(key: "cdescription_10"),
                getString(key: "cdescription_11"),
                getString(key: "cdescription_12"),
            ]
            physicalLabels = [
                getString(key: "cdescription_13"),
                getString(key: "cdescription_14"),
                getString(key: "cdescription_15"),
                getString(key: "cdescription_16"),
                getString(key: "cdescription_17"),
                getString(key: "cdescription_18"),
            ]
            tacticsLabels = [
                getString(key: "cdescription_19"),
                getString(key: "cdescription_20"),
                getString(key: "cdescription_21"),
                getString(key: "cdescription_22"),
                getString(key: "cdescription_23"),
                getString(key: "cdescription_24"),
            ]
        }
        setRadarChart(radar: radar_skills, descriptions: listSkills)
        setRadarChart(radar: radar_individual_technique, descriptions: listIndividualTechnique)
        setRadarChart(radar: radar_physical_quantities, descriptions: listPhysicalQuantities)
        setRadarChart(radar: radar_tactics, descriptions: listTactics)
    }
    
    func setRadarChart(radar: RadarChartView, descriptions: [Description]) {
        radar.chartDescription?.enabled = false
        radar.legend.enabled = false
        radar.rotationEnabled = false
        radar.webLineWidth = 1
        radar.webColor = UIColor.from(hex: "#707070")
        radar.innerWebLineWidth = 1
        radar.innerWebColor = UIColor.from(hex: "707070")
        radar.webAlpha = 100
        
        let xAxis: XAxis = radar.xAxis
        xAxis.labelFont = .systemFont(ofSize: 7, weight: .regular)
        xAxis.valueFormatter = self
        xAxis.labelTextColor = UIColor.from(hex: "#707070")
        
        let yAxis = radar.yAxis
        yAxis.setLabelCount(5, force: true)
        yAxis.axisMaximum  = 12
        yAxis.drawLabelsEnabled = false
        
        setData(radar: radar, descriptions: descriptions)
    }
    
    func setData(radar: RadarChartView, descriptions: [Description]) {
        var entries: [RadarChartDataEntry] = []
        for one in descriptions {
            entries.append(RadarChartDataEntry(value: Double(one.value)))
        }
        
        let set : RadarChartDataSet = RadarChartDataSet(values: entries, label: "My")
        set.setColor(UIColor.from(hex: "B4D969"))
        set.fillColor = UIColor.clear
        set.lineWidth = 2
        set.drawHighlightCircleEnabled = false
        set.highlightCircleFillColor = UIColor.from(hex: "#048797")
        set.highlightCircleInnerRadius = 3
        set.highlightCircleStrokeColor = UIColor.from(hex: "#048797")
        set.highlightCircleOuterRadius = 3
        set.setDrawHighlightIndicators(false)
        
        let data = RadarChartData(dataSet: set)
        data.setDrawValues(false)
        data.highlightEnabled = true
        
        radar.data = data
    }
    
    @IBAction func onClickStrength(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "StrengthVC") as! StrengthVC
        controller.user = user
        self.parentVC.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ProfileDescriptionViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if axis == radar_skills.xAxis {
            return skillLabels[Int(value) % skillLabels.count]
        }
        if axis == radar_individual_technique.xAxis {
            return individualLabels[Int(value) % individualLabels.count]
        }
        if axis == radar_physical_quantities.xAxis {
            return physicalLabels[Int(value) % physicalLabels.count]
        }
        if axis == radar_tactics.xAxis {
            return tacticsLabels[Int(value) % tacticsLabels.count]
        }
        return ""
    }
}

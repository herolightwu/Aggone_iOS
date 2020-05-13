//
//  PsychomotilityViewController.swift
//  Aggone
//
//  Created by APPLE on 2019/4/2.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import Charts

class SkillViewController: UIViewController {

    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var radar_chart: RadarChartView!
    
    var page_index: Int!
    var skills: [Description] = []
    var user: User!
    var labels: [String] = []
    var ids:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDescription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }

    func loadDescription() {
        API.getAllDescriptionsByUserid(user_id: user.id, onSuccess: { response in
            self.skills = self.getDescriptions(user_id: self.user.id, ids: self.ids, descriptions: response)
            self.table_view.reloadData()
            self.setRadarChart(radar: self.radar_chart, descriptions: self.skills)
        }, onFailed: { error in
            self.showToast(message: error)
        })
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
}

extension SkillViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath) as! SkillCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(parent: self, type: user.type, description: skills[indexPath.row])
        return cell
    }
}

extension SkillViewController: SkillCellDelegate {
    func onClickMinus(index: Int) {
        if skills[index].value == 0 { return }
        let skill = skills[index]
        skill.value -= 1
        API.updateDescription(description: skill, onSuccess: { response in
            self.skills[index] = response
            self.table_view.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            self.setData(radar: self.radar_chart, descriptions: self.skills)
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
    
    func onClickPlus(index: Int) {
        if skills[index].value == Constants.MAX_DESCRIPTION { return }
        let skill = skills[index]
        skill.value += 1
        API.updateDescription(description: skill, onSuccess: { response in
            self.skills[index] = response
            self.table_view.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            self.setData(radar: self.radar_chart, descriptions: self.skills)
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
}

extension SkillViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value) % labels.count]
    }
}

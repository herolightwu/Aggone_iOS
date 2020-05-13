//
//  StatsViewController.swift
//  Aggone
//
//  Created by tiexiong on 6/1/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import Charts


class StatsViewController: UIViewController {
    
    @IBOutlet weak var label_pref: UILabel!
    @IBOutlet weak var label_statistics: UILabel!
    @IBOutlet weak var label_match: UILabel!
    @IBOutlet weak var label_ratio: UILabel!
    
    @IBOutlet weak var chart: LineChartView!
    
    @IBOutlet weak var image_chart1: UIImageView!
    @IBOutlet weak var image_chart2: UIImageView!
    @IBOutlet weak var image_chart3: UIImageView!
    @IBOutlet weak var image_chart4: UIImageView!
    
    @IBOutlet weak var label_percent1: UILabel!
    @IBOutlet weak var label_percent4: UILabel!
    @IBOutlet weak var label_percent2: UILabel!
    @IBOutlet weak var label_percent3: UILabel!
    
    @IBOutlet weak var label_skill1: UILabel!
    @IBOutlet weak var label_skill2: UILabel!
    @IBOutlet weak var label_skill3: UILabel!
    @IBOutlet weak var label_skill4: UILabel!
    
    @IBOutlet weak var label_skill_average: UILabel!
    
    @IBOutlet weak var const_width1: NSLayoutConstraint!
    @IBOutlet weak var const_width2: NSLayoutConstraint!
    @IBOutlet weak var const_width3: NSLayoutConstraint!
    @IBOutlet weak var const_width4: NSLayoutConstraint!
    
    @IBOutlet weak var view_disable: UIView!
    @IBOutlet weak var lb_dis_title: UILabel!
    @IBOutlet weak var lb_dis_desc: UILabel!
    
    
    var user: User!
    
    var monthResult: [[Skill]] = []
    var skills: [Description] = []
    
    var labels:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lb_dis_title.text = getString(key: "stats_disable_noti")
        lb_dis_desc.text = getString(key: "stats_disable_desc")
        let months_str = getString(key: "months_array")
        labels = months_str.components(separatedBy: ",")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        setViewController()
    }
    
    func setViewController() {
        if user.type == Constants.AGENT || user.type == Constants.COMPANY {
            view_disable.isHidden = false
        } else{
            view_disable.isHidden = true
            let year = Calendar.current.component(.year, from: Date())
            API.getYearResultSummary(user: user, year: year, onSuccess: { response in
                self.monthResult.removeAll()
                for one in response {
                    self.monthResult.append(UIViewController.getSportSkills(sport: self.user.type == Constants.PLAYER ? self.user.sport : Constants.STATS_COACH, apiResult: one))
                }
                self.setLineChart()
                self.getSkills()
            }, onFailed: { error in
                self.showToast(message: error)
            })
        }
        
    }
    
    func getSkills() {
        API.getAllDescriptionsByUserid(user_id: user.id, onSuccess: { response in
            var ids:[Int] = []
            if self.user.type == Constants.PLAYER {
                ids = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
            } else {
                ids = [24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
            }
            self.skills = self.getDescriptions(user_id: self.user.id, ids: ids, descriptions: response)
            self.skills.sort(by: { $0.value > $1.value })
            self.setPieChart()
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
    
    func setLineChart() {
        chart.chartDescription?.enabled = false
        chart.isMultipleTouchEnabled = false
        chart.dragEnabled = false
        chart.setScaleEnabled(false)
        chart.pinchZoomEnabled = false
        chart.drawGridBackgroundEnabled = false
        
        setStatisticsData()
        
        let xAxis = chart.xAxis
        xAxis.setLabelCount(12, force: true)
        xAxis.valueFormatter = self
        xAxis.labelTextColor = UIColor.from(hex: "#404040")
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.axisLineColor = UIColor.from(hex: "#707070")
        
        let yAxis = chart.leftAxis
        yAxis.setLabelCount(10, force: true)
        yAxis.labelTextColor = UIColor.from(hex: "#404040")
        yAxis.axisMinimum = 0
        yAxis.labelPosition = .outsideChart
        yAxis.drawGridLinesEnabled = false
        yAxis.axisLineColor = UIColor.from(hex: "#707070")
        
        chart.rightAxis.enabled = false
        let legend = chart.legend
        legend.enabled = false
        
        let legendLabels = getLabels(user: user)
        label_statistics.text = legendLabels[0]
        label_match.text = legendLabels[1]
        label_ratio.text = legendLabels[2]
        
        chart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
    }
    
    func setStatisticsData() {
        var value1: [ChartDataEntry] = []
        var value2: [ChartDataEntry] = []
        var value3: [ChartDataEntry] = []
        
        for i in 0..<12 {
            let val = getStatistics(user: user, skills: monthResult[i])
            value1.append(ChartDataEntry(x: Double(i), y: Double(val)))
        }
        for i in 0..<12 {
            let val = getMatch(user: user, skills: monthResult[i])
            value2.append(ChartDataEntry(x: Double(i), y: Double(val)))
        }
        for i in 0..<12 {
            let val = getRatio(user: user, skills: monthResult[i])
            value3.append(ChartDataEntry(x: Double(i), y: Double(val)))
        }
        
        let set1 = LineChartDataSet(values: value1, label: "set1")
        set1.mode = .cubicBezier
        set1.cubicIntensity = 0.2
        set1.drawFilledEnabled = true
        set1.drawCirclesEnabled = false
        set1.lineWidth = 0
        set1.setColor(UIColor.from(hex: "#F7A055"))
        set1.fillColor = UIColor.from(hex: "#F7A055")
        set1.fillAlpha = 0.6
        
        let set2 = LineChartDataSet(values: value2, label: "set2")
        set2.mode = .cubicBezier
        set2.cubicIntensity = 0.2
        set2.drawFilledEnabled = true
        set2.drawCirclesEnabled = false
        set2.lineWidth = 0
        set2.setColor(UIColor.from(hex: "#F76055"))
        set2.fillColor = UIColor.from(hex: "#F76055")
        set2.fillAlpha = 0.6
        
        let set3 = LineChartDataSet(values: value3, label: "set3")
        set3.mode = .cubicBezier
        set3.cubicIntensity = 0.2
        set3.drawFilledEnabled = true
        set3.drawCirclesEnabled = false
        set3.lineWidth = 0
        set3.setColor(UIColor.from(hex: "#9B3655"))
        set3.fillColor = UIColor.from(hex: "#9B3655")
        set3.fillAlpha = 0.6
        
        let set4 = LineChartDataSet(values: value1, label: "set4")
        set4.mode = .linear
        set4.drawCirclesEnabled = true
        set4.setCircleColor(UIColor.from(hex: "#F7A055"))
        set4.circleRadius = 4
        set4.lineWidth = 2
        set4.setColor(UIColor.white)
        
        let data = LineChartData(dataSets: [set1, set2, set3, set4])
        data.setDrawValues(false)
        
        chart.data = data
    }
    
    func setPieChart() {
        var count: Int = 0
        var sum: Int = 0
        for skill in skills {
            if skill.value > 0 {
                count += 1
                sum += skill.value
            }
        }
        
        let percent1 = skills[0].value * 100 / max(sum, 1)
        let percent2 = skills[1].value * 100 / max(sum, 1)
        let percent3 = skills[2].value * 100 / max(sum, 1)
        let percent4 = skills[3].value * 100 / max(sum, 1)
        
        label_percent1.text = "\(percent1)%"
        label_percent2.text = "\(percent2)%"
        label_percent3.text = "\(percent3)%"
        label_percent4.text = "\(percent4)%"
        
        label_skill1.text = getDescriptionName(type: user.type, id: skills[0].type)
        label_skill2.text = getDescriptionName(type: user.type, id: skills[1].type)
        label_skill3.text = getDescriptionName(type: user.type, id: skills[2].type)
        label_skill4.text = getDescriptionName(type: user.type, id: skills[3].type)
        
        let skill_average = Float(sum) / Float(max(count, 1))
        label_skill_average.text = String.init(format: "%.0f", skill_average)

        const_width1.constant = CGFloat(1.4 * Float(percent1) / 3 + 70.0 / 3)
        const_width2.constant = CGFloat(1.4 * Float(percent2) / 3 + 70.0 / 3)
        const_width3.constant = CGFloat(1.4 * Float(percent3) / 3 + 70.0 / 3)
        const_width4.constant = CGFloat(1.4 * Float(percent4) / 3 + 70.0 / 3)

        var ratio_count: Int = 0
        var ratio_sum: Float = 0
        for i in 0..<12 {
            let val = getStatistics(user: user, skills: monthResult[i])
            if val > 0 {
                ratio_sum += val
                ratio_count += 1
            }
        }
        let ratio_average = ratio_sum / Float(max(ratio_count, 1)) / getSkillCount(user:user)
        let perf = ratio_average / max(skill_average, 1)	
        label_pref.text = String.init(format: "%.1f", min(perf, 10))
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickAdvancedStats(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        controller.user = self.user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickHome(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickLookup(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LookUpViewController") as! LookUpViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickChat(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension StatsViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value) % labels.count]
    }
}

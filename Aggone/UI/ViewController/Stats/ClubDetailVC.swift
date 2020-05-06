//
//  ClubDetailVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 5/4/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import Charts
import JGProgressHUD

class ClubDetailVC: UIViewController {
    
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var label_statistics: UILabel!
    @IBOutlet weak var label_match: UILabel!
    @IBOutlet weak var label_ratio: UILabel!
    @IBOutlet weak var btn_edit: UIButton!
    
    @IBOutlet weak var chart: LineChartView!
    
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var constraint_collection_height: NSLayoutConstraint!
    @IBOutlet weak var circle_victory: CircularProgressView!
    @IBOutlet weak var lb_victory: UILabel!
    @IBOutlet weak var circle_draw: CircularProgressView!
    @IBOutlet weak var lb_draw: UILabel!
    @IBOutlet weak var circle_defeat: CircularProgressView!
    @IBOutlet weak var lb_defeat: UILabel!
        
    var results: [[String]] = []
    var clubNames: [String] = []
    var skillNames: [String] = []
    var monthResult: [[Skill]] = []
    
    var user: User!
    var hud: JGProgressHUD!
    var sTitle: String!
    
    var labels:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
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
        if user.id != AppData.user.id {
            btn_edit.isHidden = true
        }
        collection_view.isHidden = true
        let sYear = sTitle.components(separatedBy: "-")
        API.getYearResultSummary(user: user, year: Int(sYear[0])!, onSuccess: { response in
            self.monthResult.removeAll()
            for one in response {
                self.monthResult.append(UIViewController.getSportSkills(sport: Constants.STATS_COACH, apiResult: one))
            }
            self.setLineChart()
            self.setCircleChart()
        }, onFailed: { error in
            self.showToast(message: error)
        })
        hud.show(in: view)
        API.getClubYearSummary(user: user, onSuccess: { response in
            self.hud.dismiss()
            self.results.removeAll()
            self.skillNames.removeAll()
            self.clubNames.removeAll()
            self.collection_view.isHidden = false
            var sum: [String] = []
            var skills = UIViewController.getSportSkills(sport: Constants.STATS_COACH, apiResult: [])
            for skill in skills {
                self.skillNames.append(skill.description)
                sum.append("0")
            }
            var row = 0
            for club in response {
                self.clubNames.append(club.0)
                skills = UIViewController.getSportSkills(sport: Constants.STATS_COACH, apiResult: club.1)
                var rowData: [String] = []
                var column = 0
                for skill in skills {
                    if skill.key == Constants.PERFORMANCE {
                        let value = Float(skill.value) / 10
                        rowData.append(String(format: "%.1f", value))
                        sum[column] = String(format: "%.1f", value + Float(sum[column])!)
                    } else {
                        rowData.append("\(skill.value)")
                        sum[column] = "\(skill.value + Int(sum[column])!)"
                    }
                    if skill.key == Constants.PERFORMANCE || skill.key == Constants.RANKING {
                        if row == response.count - 1 {
                            sum[column] = String(format: "%.1f", Float(sum[column])! / Float(response.count))
                        }
                    }
                    column += 1
                }
                self.results.append(rowData)
                row += 1
            }
            self.results.append(sum)
            self.constraint_collection_height.constant = CGFloat((self.results.count + 1) * 40)
            self.collection_view.reloadData()
        }, onFailed: { error in
            self.hud.dismiss()
            self.showToast(message: error)
        })
        
        lb_title.text = sTitle
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
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickEdit(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ClubResultViewController") as! ClubResultViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func setCircleChart(){
        var value: Float = 0
        value = getVictoryRate(skill_list:monthResult, user:user)
        lb_victory.text = getString(key: "txt_victory") + " \(Int(value))%"
        circle_victory.outerProgress = CGFloat(value / Float(100))
        circle_victory.progress = CGFloat(value / Float(100))
        circle_victory.simpleShape()
        
        value = getDrawsRate(skill_list:monthResult, user:user)
        lb_draw.text = getString(key: "txt_draw") + " \(Int(value))%"
        circle_draw.outerProgress = CGFloat(value / Float(100))
        circle_draw.progress = CGFloat(value / Float(100))
        circle_draw.simpleShape()
        
        value = getDefeatsRate(skill_list:monthResult, user:user)
        lb_defeat.text = getString(key: "txt_defeat") + " \(Int(value))%"
        circle_defeat.outerProgress = CGFloat(value / Float(100))
        circle_defeat.progress = CGFloat(value / Float(100))
        circle_defeat.simpleShape()
    }

}

extension ClubDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return results.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillNames.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
        if indexPath.section == numberOfSections(in: collectionView) - 1 {
            cell.backgroundColor = UIColor.from(hex: "#83BE3D")
        } else if indexPath.section % 2 != 0 {
            cell.backgroundColor = UIColor.from(hex: "#D3D3D3")
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.label_text.text = getString(key: "year_name")
            } else {
                cell.label_text.text = skillNames[indexPath.row - 1]
            }
        } else {
            if indexPath.row == 0 {
                if indexPath.section == numberOfSections(in: collection_view) - 1 {
                    cell.label_text.text = getString(key: "total")
                } else {
                    cell.label_text.text = clubNames[indexPath.section - 1]
                }
            } else {
                cell.label_text.text = results[indexPath.section - 1][indexPath.row - 1]
            }
        }
        cell.label_text.textAlignment = .center
        if indexPath.section == numberOfSections(in: collection_view) - 1 {
            cell.label_text.textColor = UIColor.white
        } else {
            cell.label_text.textColor = UIColor.from(hex: "#404040")
        }
        return cell
    }
    
}

extension ClubDetailVC: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value) % labels.count]
    }
}

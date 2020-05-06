//
//  ClubChartTVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 5/6/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import Charts

protocol ClubChartTVCDelegate {
    func onClickAdvanced(ind: Int!)
}

class ClubChartTVC: UITableViewCell {

    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var label_statistics: UILabel!
    @IBOutlet weak var label_match: UILabel!
    @IBOutlet weak var label_ratio: UILabel!
    @IBOutlet weak var view_legend: UIView!
    
    var delegate: ClubChartTVCDelegate!
    var index: Int!
    var legendLabels: [String] = []
    
    var labels:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chart.chartDescription?.enabled = false
        chart.isMultipleTouchEnabled = false
        chart.dragEnabled = false
        chart.setScaleEnabled(false)
        chart.pinchZoomEnabled = false
        chart.drawGridBackgroundEnabled = false
        
        legendLabels = getLabels()
        label_statistics.text = legendLabels[0]
        label_match.text = legendLabels[1]
        label_ratio.text = legendLabels[2]
        
        view_legend.layer.borderWidth = 1
        view_legend.layer.masksToBounds = false
        view_legend.layer.borderColor = priDarkColor.cgColor
        view_legend.layer.cornerRadius = 3
        view_legend.clipsToBounds = true
        
        let months_str = getString(key: "months_array")
        labels = months_str.components(separatedBy: ",")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(monthData: [[Skill]]){        
        var value1: [ChartDataEntry] = []
        var value2: [ChartDataEntry] = []
        var value3: [ChartDataEntry] = []
        
        for i in 0..<12 {
            let val = getStatistics(skills: monthData[i])
            value1.append(ChartDataEntry(x: Double(i), y: Double(val)))
        }
        for i in 0..<12 {
            let val = getMatch(skills: monthData[i])
            value2.append(ChartDataEntry(x: Double(i), y: Double(val)))
        }
        for i in 0..<12 {
            let val = getRatio(skills: monthData[i])
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
        
        chart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
    }

    @IBAction func onClickAdvanced(_ sender: Any) {
        if delegate != nil {
            delegate.onClickAdvanced(ind: index)
        }
    }
    
    func getStatistics(skills: [Skill])->Float {
        var result: Float = 0
        let stat_key_str = getString(key:"stat_coach_key")
        let stat_key = stat_key_str.components(separatedBy: ",")
        result = Float(getSkillValue(key: stat_key[1], skills: skills))
        return result
    }
    
    func getMatch(skills: [Skill])->Float {
        var result: Float = 0
        result = getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills) == 0 ? 0 :
        Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_GAMES_PLAYED, skills: skills))
        return result
    }
    
    func getRatio(skills: [Skill])->Float {
        var result: Float = 0
        result = getSkillValue(key: Constants.STATS_DEFEATS, skills: skills) == 0 ? 0 : Float(getSkillValue(key: Constants.STATS_VICTORIES, skills: skills)) / Float(getSkillValue(key: Constants.STATS_DEFEATS, skills: skills))
        return result
    }
    
    func getSkillValue(key: String, skills: [Skill])->Int {
        for one in skills {
            if one.key == key {
                return one.value
            }
        }
        return 0
    }
    
    func getLabels()->[String] {
        return [getString(key: "statistics"), getString(key: "match_win_percent"), getString(key: "ratio")]
    }
}

extension ClubChartTVC: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value) % labels.count]
    }
}

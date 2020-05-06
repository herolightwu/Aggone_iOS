//
//  AudienceVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/24/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import Charts
import JGProgressHUD

class AudienceVC: UIViewController {

    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_story_views: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var lb_total_value: UILabel!
    @IBOutlet weak var lb_view_prefix: UILabel!
    @IBOutlet weak var lb_view_value: UILabel!
    @IBOutlet weak var lb_value_view: UILabel!
    @IBOutlet weak var btn_today: UIButton!
    @IBOutlet weak var btn_week: UIButton!
    @IBOutlet weak var btn_month: UIButton!
    @IBOutlet weak var view_btn: UIView!
    @IBOutlet weak var lb_visitors: UILabel!
    @IBOutlet weak var lb_profile_title: UILabel!
    @IBOutlet weak var lb_profile_value: UILabel!
    @IBOutlet weak var lb_club_title: UILabel!
    @IBOutlet weak var lb_club_value: UILabel!
    @IBOutlet weak var lb_agent_title: UILabel!
    @IBOutlet weak var lb_agent_value: UILabel!
    @IBOutlet weak var lb_coach_title: UILabel!
    @IBOutlet weak var lb_coach_value: UILabel!
    @IBOutlet weak var lb_player_title: UILabel!
    @IBOutlet weak var lb_player_value: UILabel!
    @IBOutlet weak var lb_company_title: UILabel!
    @IBOutlet weak var lb_company_value: UILabel!
    @IBOutlet weak var lb_staff_title: UILabel!
    @IBOutlet weak var lb_staff_value: UILabel!
    @IBOutlet weak var lb_total_views: UILabel!
    @IBOutlet weak var lb_video_title: UILabel!
    @IBOutlet weak var lb_video_value: UILabel!
    @IBOutlet weak var lb_stars_title: UILabel!
    @IBOutlet weak var lb_stars_value: UILabel!
    
    var mode : Int = Constants.AUDIENCE_TODAY
    var def_timestamp: Int64 = 0
    var data: Audience! = Audience.init()
    var vStatic: ViewStatic! = ViewStatic.init()
    var hud: JGProgressHUD!
    
    var mMonths : [String] = []
    var mWeekDays : [String] = []

    var mWeeks : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let months_str = getString(key: "months_array")
        mMonths = months_str.components(separatedBy: ",")
        let weekdays_str = getString(key: "week_day_array")
        mWeekDays = weekdays_str.components(separatedBy: ",")
        let weeks_str = getString(key: "weeks_array")
        mWeeks = weeks_str.components(separatedBy: ",")
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setViewController(){
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        lb_title.text = getString(key: "profile_audience")
        lb_view_prefix.text = getString(key: "audience_views_suffix")
        lb_value_view.text = getString(key: "audience_views_suffix")
        lb_visitors.text = getString(key: "audience_visitors")
        lb_story_views.text = getString(key: "audience_story_views")
        lb_profile_title.text = getString(key: "audience_total_profile")
        lb_club_title.text = getString(key: "team_club")
        lb_agent_title.text = getString(key: "agent")
        lb_coach_title.text = getString(key: "coach")
        lb_player_title.text = getString(key: "player")
        lb_company_title.text = getString(key: "company")
        lb_staff_title.text = getString(key: "staff")
        lb_total_views.text = getString(key: "audience_total_views")
        lb_video_title.text = getString(key: "audience_view_video")
        lb_stars_title.text = getString(key: "audience_star_video")
        
        view_btn.layer.cornerRadius = 7
        view_btn.layer.borderWidth = 2
        view_btn.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        view_btn.clipsToBounds = true
        
        btn_today.layer.cornerRadius = 0
        btn_today.layer.borderWidth = 1
        btn_today.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_today.clipsToBounds = true
        
        btn_week.layer.cornerRadius = 0
        btn_week.layer.borderWidth = 1
        btn_week.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_week.clipsToBounds = true
        
        btn_month.layer.cornerRadius = 0
        btn_month.layer.borderWidth = 1
        btn_month.layer.borderColor = UIColor.from(hex: "#82BF3F").cgColor
        btn_month.clipsToBounds = true
        
        btn_today.setTitle(getString(key: "audience_today"), for: .normal)
        btn_week.setTitle(getString(key: "audience_week"), for: .normal)
        btn_month.setTitle(getString(key: "audience_month"), for: .normal)
                        
        let timestamp = NSDate().timeIntervalSince1970
        def_timestamp = Int64(timestamp / 86400) * 86400
        
        //setting barchart
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        // if more than 60 entries are displayed in the chart, no values will be
        // drawn
        barChartView.maxVisibleCount = 10
        // scaling can now only be done on x- and y-axis separately
        barChartView.pinchZoomEnabled = false
        barChartView.drawGridBackgroundEnabled = false

        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.valueFormatter = self
        xAxis.axisMinimum = 0

        let yAxisFormatter = NumberFormatter()
        yAxisFormatter.minimumFractionDigits = 0
        yAxisFormatter.maximumFractionDigits = 1
        yAxisFormatter.negativeSuffix = " "
        yAxisFormatter.positiveSuffix = " "

        let yAxis = barChartView.leftAxis
        yAxis.labelCount = 5
        yAxis.labelFont = .systemFont(ofSize: 10)
        yAxis.valueFormatter = DefaultAxisValueFormatter(formatter: yAxisFormatter)
        yAxis.labelPosition = .outsideChart
        yAxis.spaceTop = 0.15
        yAxis.axisMinimum = 0
        yAxis.drawGridLinesEnabled = false

        barChartView.rightAxis.enabled = false
        barChartView.legend.enabled = false
        
        hud.show(in: view)
        API.getStoryViewStatics(basetime: def_timestamp, onSuccess: { response in
            self.hud.dismiss()
            self.vStatic = response
            self.refreshButton()
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
        
        API.getAudienceStatics(onSuccess: { response in
            self.data = response
            self.refreshButton()
        }, onFailed: { err in
//            self.showToast(message: err)
        })
        refreshButton()
    }
    
    func refreshButton(){
        switch mode {
        case Constants.AUDIENCE_WEEK:
            btn_week.setTitleColor(UIColor.white, for: .normal)
            btn_week.backgroundColor = UIColor.from(hex: "#82BF3F")
            btn_today.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_today.backgroundColor = UIColor.white
            btn_month.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_month.backgroundColor = UIColor.white
        case Constants.AUDIENCE_MONTH:
            btn_month.setTitleColor(UIColor.white, for: .normal)
            btn_month.backgroundColor = UIColor.from(hex: "#82BF3F")
            btn_today.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_today.backgroundColor = UIColor.white
            btn_week.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_week.backgroundColor = UIColor.white
        default:
            btn_today.setTitleColor(UIColor.white, for: .normal)
            btn_today.backgroundColor = UIColor.from(hex: "#82BF3F")
            btn_week.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_week.backgroundColor = UIColor.white
            btn_month.setTitleColor(UIColor.from(hex: "#82BF3F"), for: .normal)
            btn_month.backgroundColor = UIColor.white
        }
        
        lb_total_value.text = Utils.formatNumber(vStatic.total)
        lb_profile_value.text = Utils.formatNumber(data.total_profile)
        lb_club_value.text = Utils.formatNumber(data.nClub)
        lb_agent_value.text = Utils.formatNumber(data.nAgent)
        lb_coach_value.text = Utils.formatNumber(data.nCoach)
        lb_player_value.text = Utils.formatNumber(data.nPlayer)
        lb_company_value.text = Utils.formatNumber(data.nCompany)
        lb_staff_value.text = Utils.formatNumber(data.nStaff)
        lb_video_value.text = Utils.formatNumber(data.view_video)
        lb_stars_value.text = Utils.formatNumber(data.star_video)
        
        setData()
    }
    
    func setData(){
        var count = 0
        var entry_Vals : [BarChartDataEntry] = []

        switch (mode){
        case Constants.AUDIENCE_WEEK:
            count = 4
            let mult = vStatic.total / 2
            for i in 0 ..< count {
                let val = Double(arc4random_uniform(UInt32(mult)))
                if i != 2 {
                    entry_Vals.append(BarChartDataEntry(x: Double(i), y: val))
                } else {
                    entry_Vals.append(BarChartDataEntry(x: Double(i), y: Double(vStatic.nweek)))
                }
            }
            if vStatic.nweek >= 0 {
                lb_view_value.text = Utils.formatNumber(vStatic.nweek)
            }
        case Constants.AUDIENCE_MONTH:
            count = 7
            let mult = vStatic.total / 2
            for i in 0 ..< count {
                let val = Double(arc4random_uniform(UInt32(mult)))
                if i != 3 {
                    entry_Vals.append(BarChartDataEntry(x: Double(i), y: val))
                } else {
                    entry_Vals.append(BarChartDataEntry(x: Double(i), y: Double(vStatic.nmonth)))
                }
            }
            if vStatic.nmonth >= 0 {
                lb_view_value.text = Utils.formatNumber(vStatic.nmonth)
            }
        default:
            count = 7
            let mult = vStatic.total / 2
            for i in 0 ..< count {
                let val = Double(arc4random_uniform(UInt32(mult)))
                if i != 3 {
                    entry_Vals.append(BarChartDataEntry(x: Double(i), y: val))
                } else {
                    entry_Vals.append(BarChartDataEntry(x: Double(i), y: Double(vStatic.ntoday)))
                }
            }
            if vStatic.ntoday >= 0 {
                lb_view_value.text = Utils.formatNumber(vStatic.ntoday)
            }
        }
        barChartView.xAxis.labelCount = count
        
        var set1: BarChartDataSet! = nil
        
//        if let set = barChartView.data?.dataSets.first as? BarChartDataSet {
//            set1 = set
//            set1.rep(entry_Vals)
//            barChartView.data?.notifyDataChanged()
//            barChartView.notifyDataSetChanged()
//        } else
//        {
            set1 = BarChartDataSet(values: entry_Vals, label: "")
            set1.drawValuesEnabled = false
                
            let mainColor = ChartColorTemplates.colorFromString("#FFB8DB68")
            let subColor = ChartColorTemplates.colorFromString("#40B8DB68")
            
            var gradientFills:[NSUIColor] = []
            if (mode == Constants.AUDIENCE_WEEK){
                gradientFills.append(subColor);
                gradientFills.append(subColor);
                gradientFills.append(mainColor);
                gradientFills.append(subColor);
            } else{
                gradientFills.append(subColor);
                gradientFills.append(subColor);
                gradientFills.append(subColor);
                gradientFills.append(mainColor);
                gradientFills.append(subColor);
                gradientFills.append(subColor);
                gradientFills.append(subColor);
            }
            set1.colors = gradientFills
            
            let data = BarChartData(dataSet: set1)
    //        data.setValueFont(UIFont(name: "System", size: 10)!)
            data.setValueTextColor(UIColor.white)
            data.barWidth = 1
            barChartView.data = data
            barChartView.data?.notifyDataChanged()
            barChartView.notifyDataSetChanged()
//        }
    }

    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickToday(_ sender: Any) {
        if mode != Constants.AUDIENCE_TODAY {
            mode = Constants.AUDIENCE_TODAY
            refreshButton()
        }
    }
    
    @IBAction func onClickWeek(_ sender: Any) {
        if mode != Constants.AUDIENCE_WEEK {
            mode = Constants.AUDIENCE_WEEK
            refreshButton()
        }
    }
    
    @IBAction func onClickMonth(_ sender: Any) {
        if mode != Constants.AUDIENCE_MONTH {
            mode = Constants.AUDIENCE_MONTH
            refreshButton()
        }
    }
    
}

extension AudienceVC: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let calendar = NSCalendar.current
        if axis == barChartView.xAxis {
            if mode == Constants.AUDIENCE_MONTH {
                let mmm = calendar.component(.month, from: Date())
                return mMonths[(Int(value) + mmm + 8) % 12];
            } else if mode == Constants.AUDIENCE_TODAY {
                let day = calendar.component(.weekday, from: Date())
                return mWeekDays[(Int(value) + day + 4) % 7];
            } else {
                let component = calendar.component(.weekOfYear, from: Date())
                let weekRange = calendar.range(of: .weekOfYear, in: .month, for: Date())
                let mm = weekRange?.index(of: component)
                return mWeeks[(Int(value) + mm!)%4];
            }
        }
        return "\(Int(value))"
    }
}

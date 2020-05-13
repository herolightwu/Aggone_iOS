//
//  ClubChartVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 5/4/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD
import Charts

class ClubChartVC: UIViewController {
    
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var btn_edit: UIButton!
    
    var hud:JGProgressHUD!
    var user: User!
    
    var titles:[String] = []
    var clubResult:[[[Skill]]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
//        btn_edit.isHidden = true
        reloadData()
    }
    
    func reloadData(){
        hud.show(in: view)
        API.getClubSummary(user_id: user.id, onSuccess: { response in
            let sorted_data = response.sorted { $0.0.lowercased() > $1.0.lowercased() }
            self.titles.removeAll()
            self.clubResult.removeAll()
            for stat in sorted_data {
                self.titles.append(stat.0)
                var monthresult:[[Skill]] = []
                for one in stat.1 {
                    monthresult.append(UIViewController.getSportSkills(sport: Constants.STATS_COACH, apiResult: one))
                }
                self.clubResult.append(monthresult)
            }
            self.hud.dismiss()
            self.table_view.reloadData()
            /*if self.titles.count == 0 && self.user.id == AppData.user.id {
                self.btn_edit.isHidden = false
            } else {
                self.btn_edit.isHidden = true
            }*/
        }, onFailed: {err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
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
    
    @IBAction func onClickEdit(_ sender: Any) {
        let year = Calendar.current.component(.year, from: Date())
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ClubStatsVC") as! ClubStatsVC
        controller.user = user
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ClubChartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let month_data = self.clubResult[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubChartTVC", for: indexPath) as! ClubChartTVC
        cell.index = indexPath.row
        cell.delegate = self
        cell.lb_title.text = titles[indexPath.row]
        cell.setCell(monthData: month_data)
        return cell
    }
}

extension ClubChartVC: ClubChartTVCDelegate{
    func onClickAdvanced(ind: Int!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ClubDetailVC") as! ClubDetailVC
        controller.user = user
        controller.sTitle = titles[ind]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

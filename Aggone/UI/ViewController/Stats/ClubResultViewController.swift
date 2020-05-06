//
//  ClubResultViewController.swift
//  Aggone
//
//  Created by APPLE on 2019/4/9.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class ClubResultViewController: UIViewController {

    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var btn_plus: UIButton!
    
    var data:[(String, [Skill])] = []
    var years_list: [[(String, [String])]] = []
    var hud: JGProgressHUD!
    var bEdits:[Bool] = []
    
    var select_year_list: [(Int, Int)] = []
    
    let month_list: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        refreshVC()
    }
    
    func setViewController() {
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        if AppData.user.type == Constants.PLAYER || AppData.user.type == Constants.COACH {
            btn_plus.setImage(UIImage(named: "add_new_club"), for: .normal)
        } else {
            btn_plus.setImage(UIImage(named: "add_new_category"), for: .normal)
        }
    }
    
    func refreshVC(){
        hud.show(in: view)
        if AppData.user.type == Constants.PLAYER || AppData.user.type == Constants.COACH {
            API.getUserResultSummary(user:AppData.user ,onSuccess: { response in
                self.hud.dismiss()
                self.data.removeAll()
                self.bEdits.removeAll()
                self.years_list.removeAll()
                self.select_year_list.removeAll()
                for one in response {
                    self.data.append((one.0, UIViewController.getSportSkills(sport: AppData.user.type == Constants.PLAYER ? AppData.user.sport : Constants.STATS_COACH, apiResult: one.1)))
                    self.bEdits.append(false)
                    self.years_list.append(one.2)
                    self.select_year_list.append((0, 0)) //Int(one.2[0].0)!, Int(one.2[0].1[0])!
                }
                
                self.table_view.reloadData()
            }, onFailed: { error in
                self.hud.dismiss()
                self.showToast(message: error)
            })
        } else {
            API.getClubYearSummary(user:AppData.user ,onSuccess: { response in
                self.hud.dismiss()
                self.data.removeAll()
                self.bEdits.removeAll()
                self.years_list.removeAll()
                self.select_year_list.removeAll()
                for one in response {
                    self.data.append((one.0, UIViewController.getSportSkills(sport:  Constants.STATS_COACH, apiResult: one.1)))
                    self.bEdits.append(false)
                    self.years_list.append(one.2)
                    self.select_year_list.append((0, 0)) //Int(one.2[0].0)!, Int(one.2[0].1[0])!
                }
                self.table_view.reloadData()
            }, onFailed: { error in
                self.hud.dismiss()
                self.showToast(message: error)
            })
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddStatsViewController") as! AddStatsViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ClubResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubResultCell", for: indexPath) as! ClubResultCell
        cell.index = indexPath.row
        cell.section = indexPath.section
        cell.setCell(skill: data[indexPath.section].1[indexPath.row], bEdit: self.bEdits[indexPath.section])
        cell.delegate = self
        if AppData.user.type == Constants.PLAYER || AppData.user.type == Constants.COACH {
            cell.clubname = data[indexPath.section].0
        } else {
            let club_str = data[indexPath.section].0
            let temp_str = club_str.components(separatedBy: "-")
            cell.clubname = temp_str[1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubResultHeaderCell") as! ClubResultHeaderCell
        cell.label_title.text = data[section].0
        cell.sect_ind = section
        cell.delegate = self
        cell.setHeaderCell(catelist:self.years_list[section], selected:self.select_year_list[section], bEdit: self.bEdits[section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubResultFooterCell") as! ClubResultFooterCell
        return cell
    }
}

extension ClubResultViewController: ClubResultHeaderCellDelegate{
    func onClickEdit(sect: Int!) {
        self.bEdits[sect] = !self.bEdits[sect]
//        self.select_year_list[sect] = (0, 0)
        self.table_view.reloadData()
    }
    
    func onClickDelete(club: String!) {
        let controller : DeleteDialog = DeleteDialog.init(nibName: "DeleteDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.handler = { () in
            
            if AppData.user.type == Constants.PLAYER || AppData.user.type == Constants.COACH {
                self.hud.show(in: self.view)
                API.deleteUserClubSummary(user_id: AppData.user.id, club: club, onSuccess: {response in
                    self.hud.dismiss()
                    self.refreshVC()
                }, onFailed: { err in
                    self.hud.dismiss()
                    self.showToast(message: err)
                })
            } else {
                API.deleteClubYearSummary(user_id: AppData.user.id, club: club, onSuccess: { response in
                    self.hud.dismiss()
                    self.refreshVC()
                }, onFailed: { err in
                    self.hud.dismiss()
                    self.showToast(message: err)
                })
            }
            
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    func onChangeYear(sect: Int!, year: Int!) {
        self.select_year_list[sect].0 = year
    }
    
    func onChangeMonth(sect: Int!, month: Int!) {
        self.select_year_list[sect].1 = month
    }
}

extension ClubResultViewController: ClubResultCellDelegate{
    func onClickPlus(club: String!, section: Int!, index: Int) {
        //if self.select_year_list[section].0 != 0 && self.select_year_list[section].1 != 0 {
            let nyear = self.select_year_list[section].0
            let nmonth = self.select_year_list[section].1
            let result = Result()
            result.user_id = AppData.user.id
            result.sport = AppData.user.sport
            result.club = club
            result.year = Int(self.years_list[section][nyear].0)!
            result.month = Int(month_list[nmonth])!
            result.value_type = 1
            result.type = data[section].1[index].key
            hud.show(in: view)
            API.adjustStatValue(result: result, onSuccess: { response in
                self.hud.dismiss()
                self.data[section].1[index].value += 1
                self.table_view.reloadData()
            }, onFailed: { err in
                self.hud.dismiss()
                self.showToast(message: err)
            })
        //}
        
    }
    
    func onClickMinus(club: String!, section: Int!, index: Int) {
        //if self.select_year_list[section].0 != 0 && self.select_year_list[section].1 != 0 {
            let result = Result()
            let nyear = self.select_year_list[section].0
            let nmonth = self.select_year_list[section].1
            result.user_id = AppData.user.id
            result.sport = AppData.user.sport
            result.club = club
//            result.year = self.select_year_list[section].0
//            result.month = self.select_year_list[section].1
            result.year = Int(self.years_list[section][nyear].0)!
            result.month = Int(month_list[nmonth])!
            result.value_type = -1
            result.type = data[section].1[index].key
            hud.show(in: view)
            API.adjustStatValue(result: result, onSuccess: { response in
                self.hud.dismiss()
                self.data[section].1[index].value -= 1
                self.table_view.reloadData()
            }, onFailed: { err in
                self.hud.dismiss()
                self.showToast(message: err)
            })
        //}
        
    }
    
    func onClickFloat(club: String!, section: Int!, index: Int) {
        let controller = NumberInputDialog.init(nibName: "NumberInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.index = index
        controller.delegate = self
        controller.club = club
        controller.section = section
        controller.text = getString(key: "performance")
        present(controller, animated: true, completion: nil)
    }
}

extension ClubResultViewController: NumberInputDialogDelegate {
    func onClickOk(index: Int, value: String) {
        
    }
    
    func onClickOk(club:String!, section: Int!, index: Int, value: String) {
        let newValue = Int(Float(value)! * 10)
        let nyear = self.select_year_list[section].0
        let nmonth = self.select_year_list[section].1
        let result = Result()
        result.user_id = AppData.user.id
        result.sport = AppData.user.sport
        result.club = club
//        result.year = self.select_year_list[section].0
//        result.month = self.select_year_list[section].1
        result.year = Int(self.years_list[section][nyear].0)!
        result.month = Int(month_list[nmonth])!
        result.value_type = 0
        result.type = data[section].1[index].key
        result.value = newValue
        hud.show(in: view)
        API.adjustStatValue(result: result, onSuccess: { response in
            self.hud.dismiss()
            self.data[section].1[index].value = newValue
            self.table_view.reloadData()
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }
}

//
//  AddStatsViewController.swift
//  Aggone
//
//  Created by APPLE on 2019/4/11.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

class AddStatsViewController: UIViewController {

    @IBOutlet weak var table_view: UITableView!
    var skills: [Skill] = []
    
    @IBOutlet weak var text_club: UITextField!
    @IBOutlet weak var text_month: UITextField!
    @IBOutlet weak var text_year: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    func setViewController() {
        text_club.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        text_month.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        text_year.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        skills.removeAll()
        table_view.reloadData()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        let club = text_club.text
        let year_str = text_year.text
        let month_str = text_month.text
        if (club?.isEmpty)! {
            showToast(message: "Please input club name")
            return
        }
        if (year_str?.isEmpty)! {
            showToast(message: "Please input year")
            return
        }
        if (month_str?.isEmpty)! {
            showToast(message: "Please input month")
            return
        }
        let year = Int(year_str!)
        let month = Int(month_str!)
        if isValidDate(year: year!, month: month!, day: 1) ==  false {
            showToast(message: "Invalid Date")
            return
        }
        API.getClubMonthResultSummary(user: AppData.user, club: club!, year: year!, month: month!, onSuccess: { response in
            self.skills = UIViewController.getSportSkills(sport: AppData.user.type == Constants.PLAYER ? AppData.user.sport : Constants.STATS_COACH, apiResult: response)
            self.table_view.reloadData()
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
}

extension AddStatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(skill: skills[indexPath.row])
        return cell
    }
}

extension AddStatsViewController: StatsCellDelegate {
    func onClickMinus(index: Int) {
        if skills[index].value == 0 { return }
        let result = Result()
        result.user_id = AppData.user.id
        result.sport = AppData.user.sport
        result.club = text_club.text!
        result.year = Int(text_year.text!)!
        result.month = Int(text_month.text!)!
        result.type = skills[index].key
        result.value = skills[index].value - 1
        API.saveResult(result: result, onSuccess: { response in
            self.skills[index].value -= 1
            self.table_view.reloadData()
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
    
    func onClickPlus(index: Int) {
        let result = Result()
        result.user_id = AppData.user.id
        result.sport = AppData.user.sport
        result.club = text_club.text!
        result.year = Int(text_year.text!)!
        result.month = Int(text_month.text!)!
        result.type = skills[index].key
        result.value = skills[index].value + 1
        if ((index == 1 || index == 2 || index == 3) && skills[0].value < result.value) {
            return
        }
        API.saveResult(result: result, onSuccess: { response in
            self.skills[index].value += 1
            self.table_view.reloadData()
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
    
    func onClickFloat(index: Int) {
        let controller = NumberInputDialog.init(nibName: "NumberInputDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.index = index
        controller.delegate = self
        controller.club = ""
        controller.text = getString(key: "performance")
        present(controller, animated: true, completion: nil)
    }
}

extension AddStatsViewController: NumberInputDialogDelegate {
    func onClickOk(index: Int, value: String) {
        let newValue = Int(Float(value)! * 10)
        let result = Result()
        result.user_id = AppData.user.id
        result.sport = AppData.user.sport
        result.club = text_club.text!
        result.year = Int(text_year.text!)!
        result.month = Int(text_month.text!)!
        result.type = skills[index].key
        result.value = newValue
        API.saveResult(result: result, onSuccess: { response in
            self.skills[index].value = newValue
            self.table_view.reloadData()
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
    func onClickOk(club:String!, section: Int!, index: Int, value: String) {
    }
}

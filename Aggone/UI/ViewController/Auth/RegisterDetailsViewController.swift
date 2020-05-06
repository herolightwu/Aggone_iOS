//
//  RegisterDetailsViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/15/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import DropDown

class RegisterDetailsViewController: UIViewController {

    @IBOutlet weak var btn_player: UIButton!
    @IBOutlet weak var btn_coach: UIButton!
    @IBOutlet weak var btn_club: UIButton!
    @IBOutlet weak var btn_agent: UIButton!
    @IBOutlet weak var btn_staff: UIButton!
    @IBOutlet weak var btn_company: UIButton!
    
    @IBOutlet weak var lb_player: UILabel!
    @IBOutlet weak var lb_coach: UILabel!
    @IBOutlet weak var lb_club: UILabel!
    @IBOutlet weak var lb_agent: UILabel!
    @IBOutlet weak var lb_staff: UILabel!
    @IBOutlet weak var lb_company: UILabel!
    @IBOutlet weak var lb_desc: UILabel!
    
    
    var email: String!
    var password: String!
    var signup_mode : Int = Constants.SIGNUP_EMAIL
    
    var type: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = Constants.PLAYER
        lb_player.text = getString(key: "player")
        lb_coach.text = getString(key: "coach")
        lb_club.text = getString(key: "team_club")
        lb_agent.text = getString(key: "agent")
        lb_staff.text = getString(key: "staff")
        lb_company.text = getString(key: "company")
        lb_desc.text = getString(key: "company_desc")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        refreshView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        AppData.user.type = type
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SelectSportViewController") as! SelectSportViewController
        controller.email = email
        controller.password = password
        controller.signup_mode = signup_mode
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func refreshView(){
        btn_player.setImage(UIImage(named: "auth_player_normal"), for: .normal)
        btn_coach.setImage(UIImage(named: "auth_coach_normal"), for: .normal)
        btn_club.setImage(UIImage(named: "auth_club_normal"), for: .normal)
        btn_agent.setImage(UIImage(named: "auth_agent_normal"), for: .normal)
        btn_staff.setImage(UIImage(named: "auth_staff_normal"), for: .normal)
        btn_company.setImage(UIImage(named: "auth_company_normal"), for: .normal)
        
        switch type {
        case Constants.PLAYER:
            btn_player.setImage(UIImage(named: "auth_player_active"), for: .normal)
        case Constants.COACH:
            btn_coach.setImage(UIImage(named: "auth_coach_active"), for: .normal)
        case Constants.TEAM_CLUB:
            btn_club.setImage(UIImage(named: "auth_club_active"), for: .normal)
        case Constants.AGENT:
            btn_agent.setImage(UIImage(named: "auth_agent_active"), for: .normal)
        case Constants.STAFF:
            btn_staff.setImage(UIImage(named: "auth_staff_active"), for: .normal)
//        case Constants.COMPANY:
        default:
            btn_company.setImage(UIImage(named: "auth_company_active"), for: .normal)
        }
    }
    
    @IBAction func onClickPlayer(_ sender: Any) {
        type = Constants.PLAYER
        refreshView()
    }
    
    
    @IBAction func onClickCoach(_ sender: Any) {
        type = Constants.COACH
        refreshView()
    }
    
    @IBAction func onClickClub(_ sender: Any) {
        type = Constants.TEAM_CLUB
        refreshView()
    }
    
    @IBAction func onClickAgent(_ sender: Any) {
        type = Constants.AGENT
        refreshView()
    }
    
    @IBAction func onClickStaff(_ sender: Any) {
        type = Constants.STAFF
        refreshView()
    }
    
    @IBAction func onClickCompany(_ sender: Any) {
        type = Constants.COMPANY
        refreshView()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

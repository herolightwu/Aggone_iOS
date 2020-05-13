//
//  ActivityDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol ActivityDialogDelegate {
    func onSelectActivity(type: Int)
}

class ActivityDialog: UIViewController {
    @IBOutlet weak var view_panel: UIView!
    
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
    
    var delegate : ActivityDialogDelegate!
    var type: Int! = Constants.PLAYER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true

        lb_player.text = getString(key: "player")
        lb_coach.text = getString(key: "coach")
        lb_club.text = getString(key: "team_club")
        lb_agent.text = getString(key: "agent")
        lb_staff.text = getString(key: "staff")
        lb_company.text = getString(key: "company")
        lb_desc.text = getString(key: "company_desc")
        refreshView()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
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
        if self.delegate != nil {
            self.delegate.onSelectActivity(type: Constants.PLAYER)
            self.actionBack()
        }
    }
    
    
    @IBAction func onClickCoach(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onSelectActivity(type: Constants.COACH)
            self.actionBack()
        }
    }
    
    @IBAction func onClickClub(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onSelectActivity(type: Constants.TEAM_CLUB)
            self.actionBack()
        }
    }
    
    @IBAction func onClickAgent(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onSelectActivity(type: Constants.AGENT)
            self.actionBack()
        }
    }
    
    @IBAction func onClickStaff(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onSelectActivity(type: Constants.STAFF)
            self.actionBack()
        }
    }
    
    @IBAction func onClickCompany(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onSelectActivity(type: Constants.COMPANY)
            self.actionBack()
        }
    }
}

//
//  ProfileTeamVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/20/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class ProfileTeamVC: UIViewController {
    
    @IBOutlet weak var btn_join: UIButton!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var constraint_table_top: NSLayoutConstraint!
    
    var parentVC: ProfileViewController!
    let refreshControl = UIRefreshControl()
    
    var hud: JGProgressHUD!
    
    var user:User!
    var users:[User] = []
    
    var bJoined : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        table_view.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
        
        if user.id == AppData.user.id || AppData.user.type > Constants.COACH || user.type == Constants.PLAYER || user.type == Constants.COACH {
            btn_join.isHidden = true
            constraint_table_top.constant = 16
        } else {
            btn_join.isHidden = false
            constraint_table_top.constant = 56
        }
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func refresh() {
        API.getTeamMembers(team_id: user.id, onSuccess: { response in
            self.users = response
            self.table_view.reloadData()
            self.refreshControl.endRefreshing()
            if !self.btn_join.isHidden {
                self.bJoined = false
                self.btn_join.setTitle("Join", for: .normal)
                for uu in response {
                    if uu.id == AppData.user.id {
                        self.bJoined = true
                        self.btn_join.setTitle("Leave", for: .normal)
                    }
                }
            }
            
        }, onFailed: { err in
            self.showToast(message: err)
            self.refreshControl.endRefreshing()
        })
    }

    @IBAction func onClickJoin(_ sender: Any) {
        hud.show(in: view)
        if bJoined {
            API.leaveTeam(team_id: user.id, user_id: AppData.user.id, onSuccess: { response in
                self.hud.dismiss()
                self.refreshControl.beginRefreshing()
                self.refreshControl.sendActions(for: .valueChanged)
            }, onFailed: { err in
                self.hud.dismiss()
                self.showToast(message: err)
            })
        } else{
            API.joinTeam(team_id: user.id, user_id: AppData.user.id, onSuccess: { response in
                self.hud.dismiss()
                self.refreshControl.beginRefreshing()
                self.refreshControl.sendActions(for: .valueChanged)
            }, onFailed: { err in
                self.hud.dismiss()
                self.showToast(message: err)
            })
        }
    }
    
}

extension ProfileTeamVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaggedUserViewCell", for: indexPath) as! TaggedUserViewCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(user: users[indexPath.row])
        return cell
    }
}

extension ProfileTeamVC:TaggedUserViewCellDelegate{
    func onClickProfileBtn(index: Int){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = users[index]
        self.parentVC.navigationController?.pushViewController(controller, animated: true)
    }
}

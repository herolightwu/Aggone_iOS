//
//  ClubStatsVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 5/22/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class ClubStatsVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!    
    
    var user: User!
    var results: [(String,[[(String, Int)]], [(String, [(String, Int)])])] = []
    
    var hud: JGProgressHUD!

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
        setViewController()
    }

    func setViewController() {
        hud.show(in: view)
        API.getSummaryByClub(user_id: user.id, onSuccess: { response in
            self.hud.dismiss()
            self.results.removeAll()
            self.results = response
            self.tableview.reloadData()
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }

    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
}

extension ClubStatsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatClubTVC", for: indexPath) as! StatClubTVC
        cell.index = indexPath.row
        cell.setCell(data: results[indexPath.row])
        cell.user = user
        return cell
    }
}

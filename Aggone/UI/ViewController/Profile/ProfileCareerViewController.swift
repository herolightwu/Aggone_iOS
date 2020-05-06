//
//  ProfileCareerViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/29/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import DropDown
import SwipeCellKit

class ProfileCareerViewController: UIViewController {

    @IBOutlet var table_view: UITableView!
    
    let refreshControl = UIRefreshControl()
    var user:User!
    var careers:[Career] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        table_view.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    @objc func refresh() {
        API.getAllCareerByUserid(user_id: user.id, onSuccess: { response in
            self.careers = response
            self.table_view.reloadData()
            self.refreshControl.endRefreshing()
        }, onFailed: { error in
            self.showToast(message: error)
            self.refreshControl.endRefreshing()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


extension ProfileCareerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return careers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCareerTableViewCell", for: indexPath) as! ProfileCareerTableViewCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(career: careers[indexPath.row])
        return cell
    }
}

extension ProfileCareerViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            if self.user.id != AppData.user.id { return }
            
            let controller : DeleteDialog = DeleteDialog.init(nibName: "DeleteDialog", bundle: nil)
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            controller.handler = { () in
                API.deleteCareer(career_id: self.careers[indexPath.row].id, onSuccess: { response in
                    self.careers.remove(at: indexPath.row)
                    self.table_view.reloadData()
                }, onFailed: { error in
                    self.showToast(message: error)
                })
            }
            self.present(controller, animated: true, completion: nil)
        }
        deleteAction.image = UIImage(named: "career_delete")
        deleteAction.backgroundColor = UIColor.white
        return [deleteAction]
    }
}

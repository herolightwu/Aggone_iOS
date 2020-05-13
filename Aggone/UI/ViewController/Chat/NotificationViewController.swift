//
//  NotificationViewController.swift
//  Aggone
//
//  Created by APPLE on 2019/4/7.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol NotificationViewControllerDelegate {
    func onClickProfile(user: User)
}

class NotificationViewController: UIViewController {

    @IBOutlet weak var table_view: UITableView!
    var notifications: [Notification] = []
    
    var delegate: NotificationViewControllerDelegate!
    
    var hud: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud = JGProgressHUD(style: .dark)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setViewController()
    }
    
    func setViewController() {
        hud.show(in: self.view)
        API.getAllNotifications(onSuccess: { response in
            self.hud.dismiss()
            self.notifications = response
            self.table_view.reloadData()
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
        
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.setCell(notification: notifications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        API.removeNotification(noti_id: notifications[indexPath.row].id, onSuccess: { response in
            
        }, onFailed: { err in
            
        })
        if delegate != nil {
            if notifications[indexPath.row].user != nil {
                delegate.onClickProfile(user: notifications[indexPath.row].user)
            } else{
                setViewController()
            }
        } else{
            setViewController()
        }
    }
}

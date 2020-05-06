//
//  AddContactViewController.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/17/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var tableview: UITableView!
    let refreshControl = UIRefreshControl()
    
    var users:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    func setViewController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableview.addSubview(refreshControl)
//        refreshControl.beginRefreshing()
//        refreshControl.sendActions(for: .valueChanged)
    }
    
    @objc func refresh() {
        API.getFollowing(onSuccess: ({ users in
            self.users = users
            self.tableview.reloadData()
            self.refreshControl.endRefreshing()
        }), onFailed: ({ error in
            self.showToast(message: error)
            self.refreshControl.endRefreshing()
        }))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
        
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
}

extension AddContactViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionCell", for: indexPath) as! SubscriptionCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(user: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        controller.user = self.users[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension AddContactViewController: SubscriptionCellDelegate {
    func onClickFollow(index: Int) {
        API.deleteFollow(user_id: users[index].id, onSuccess: { response in
            self.users.remove(at: index)
            self.tableview.reloadData()
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
}

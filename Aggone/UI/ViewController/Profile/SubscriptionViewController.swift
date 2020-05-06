//
//  SubscriptionViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/28/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

class SubscriptionViewController: UIViewController {

    @IBOutlet var table_view: UITableView!
    @IBOutlet weak var lb_total: UILabel!
    
    let refreshControl = UIRefreshControl()
    var users:[User] = []

    var user:User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    func setViewController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        table_view.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
        
        lb_total.text = "\(Utils.formatNumber(users.count)) Subscriptions"
    }
    
    @objc func refresh() {
        API.getFollowing(onSuccess: ({ users in
            self.users = users
            self.lb_total.text = "\(Utils.formatNumber(users.count)) Subscriptions"
            self.table_view.reloadData()
            self.refreshControl.endRefreshing()
        }), onFailed: ({ error in
            self.showToast(message: error)
            self.refreshControl.endRefreshing()
        }))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
}

extension SubscriptionViewController: UITableViewDelegate, UITableViewDataSource {
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
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = self.users[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension SubscriptionViewController: SubscriptionCellDelegate {
    func onClickFollow(index: Int) {
        API.deleteFollow(user_id: users[index].id, onSuccess: { response in
            self.users.remove(at: index)
            self.table_view.reloadData()
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
}

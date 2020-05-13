//
//  FilterResultViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/23/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

class FilterResultViewController: UIViewController {

    @IBOutlet weak var table_view: UITableView!
        
    var list_users:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
}

extension FilterResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LookingPlayerTableViewCell", for: indexPath) as! LookingPlayerTableViewCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(user: list_users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = list_users[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension FilterResultViewController: LookingPlayerCellDelegate {
}

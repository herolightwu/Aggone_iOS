//
//  MessageViewController.swift
//  Aggone
//
//  Created by APPLE on 2019/4/5.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import JGProgressHUD
import SwipeCellKit

protocol MessageViewControllerDelegate {
    func onChat(user: User)
}

class MessageViewController: UIViewController {

    @IBOutlet weak var table_view: UITableView!
    var contacts: [Contact] = []
    
    var delegate: MessageViewControllerDelegate!
    var ref: DatabaseReference!
    
    var hud: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
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
        ref.child(Constants.FIREBASE_CONTACT)
        .child(AppData.user.id)
        .queryOrdered(byChild: Constants.FIREBASE_TIMESTAMP)
        .observeSingleEvent(of: .value, with: { snapshot in
            self.hud.dismiss()
            self.contacts.removeAll()
            for snap in snapshot.children {
                let dic = (snap as! DataSnapshot).value as! [String: Any]
                let contact = Contact(dictionary: dic)
                self.contacts.append(contact)
            }
            self.contacts.reverse()
            self.table_view.reloadData()
        }, withCancel: { error in
            self.hud.dismiss()
            self.showToast(message: error.localizedDescription)
        })
    }
}

extension MessageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(contact: contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            delegate.onChat(user: contacts[indexPath.row].user)
        }
    }
}

extension MessageViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            let controller : DeleteDialog = DeleteDialog.init(nibName: "DeleteDialog", bundle: nil)
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            controller.handler = { () in
                let one = self.contacts[indexPath.row]
                self.ref.child(Constants.FIREBASE_CONTACT)
                .child(AppData.user.id)
                .child(one.user.id)
                .setValue(nil)
                self.contacts.remove(at: indexPath.row)
                self.table_view.reloadData()
            }
            self.present(controller, animated: true, completion: nil)
        }
        deleteAction.image = UIImage(named: "career_delete")
        deleteAction.backgroundColor = UIColor.white
        return [deleteAction]
    }
}

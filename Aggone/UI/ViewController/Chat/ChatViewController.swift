//
//  ChatViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/25/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwipeCellKit

class ChatViewController: UIViewController {

    @IBOutlet var table_view: UITableView!
    @IBOutlet var text_message: UITextField!
    @IBOutlet weak var view_message: UIView!
    @IBOutlet weak var label_name: UILabel!
    
    var chats:[Chat] = []
    var ref: DatabaseReference!
    
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func setViewController() {
        view_message.layer.cornerRadius = 5
        view_message.layer.borderWidth = 1
        view_message.layer.borderColor = UIColor.from(hex: "#BEBEBF").cgColor
        view_message.clipsToBounds = true
        
        label_name.text = user.username
//        text_message.delegate = self
        
        let room = UIViewController.getChatId(a: AppData.user, b: user)
        ref.child(Constants.FIREBASE_CHAT).child(room).queryLimited(toFirst: 100).observe(.childAdded, with: { snapshot in
            if snapshot.value != nil {
                let chat = Chat(dictionary: snapshot.value as! [String:Any])
                self.chats.append(chat)
                self.table_view.reloadData()
                self.table_view.scrollToRow(at: IndexPath(row: self.chats.count-1, section: 0), at: .bottom, animated: true)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickImage(_ sender: Any) {
    }
    
    @IBAction func onClickEmoticon(_ sender: Any) {
    }
    
    @IBAction func onClickSend(_ sender: Any) {
        if text_message.text?.isEmpty == false {
            sendMessage(message: text_message.text!)
        }
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chats[indexPath.row].sender == AppData.user.id {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageMineTableViewCell", for: indexPath) as! MessageMineTableViewCell
            cell.delegate = self
            cell.setCell(chat: chats[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageOtherTableViewCell", for: indexPath) as! MessageOtherTableViewCell
            cell.user = self.user
            cell.setCell(chat: chats[indexPath.row])
            return cell
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text?.isEmpty == false {
            sendMessage(message: textField.text!)
        }
        return true
    }
    
    func sendMessage(message: String) {
        let chat = Chat()
        chat.sender = AppData.user.id
        chat.message = message
        chat.type = Constants.FIREBASE_TEXT
        chat.timestamp = Int64(Date().timeIntervalSince1970)
        
        let room = UIViewController.getChatId(a: AppData.user, b: user)
        
        chat.id = ref.child(Constants.FIREBASE_CHAT).child(room).childByAutoId().key!
        ref.child(Constants.FIREBASE_CHAT).child(room).child(chat.id).setValue(chat.dictionary)
        
        ref.child(Constants.FIREBASE_CONTACT).child(user.id).child(AppData.user.id).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                let old = Contact(dictionary: snapshot.value as! [String:Any])
                old.unread_count += 1
                old.user = AppData.user
                old.message = chat.message
                old.timestamp = chat.timestamp
                old.type = chat.type
                
                self.ref.child(Constants.FIREBASE_CONTACT).child(self.user.id).child(AppData.user.id).setValue(old.dictionary)
            } else {
                let contact = Contact()
                contact.message = chat.message
                contact.timestamp = chat.timestamp
                contact.type = chat.type
                contact.user = AppData.user
                contact.unread_count = 1
                self.ref.child(Constants.FIREBASE_CONTACT).child(self.user.id).child(AppData.user.id).setValue(contact.dictionary)
            }
        }, withCancel: { error in
            self.showToast(message: error.localizedDescription)
        })
        
        let contact = Contact()
        contact.message = chat.message
        contact.timestamp = chat.timestamp
        contact.type = chat.type
        contact.user = user
        contact.unread_count = 0
        
        ref.child(Constants.FIREBASE_CONTACT).child(AppData.user.id).child(self.user.id).setValue(contact.dictionary)
        text_message.text = ""
        
        API.pushChatNotification(user_id: user.id, msg: chat.message, onSuccess: { response in
            self.table_view.scrollToRow(at: IndexPath(row: self.chats.count-1, section: 0), at: .bottom, animated: true)
        }, onFailed: { error in
            
        })
    }
}

extension ChatViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            let controller : DeleteDialog = DeleteDialog.init(nibName: "DeleteDialog", bundle: nil)
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            controller.handler = { () in
                let one = self.chats[indexPath.row]
                let room = UIViewController.getChatId(a: AppData.user, b: self.user)
                self.ref.child(Constants.FIREBASE_CHAT).child(room)
                    .child(one.id)
                    .setValue(nil)
                self.chats.remove(at: indexPath.row)
                self.table_view.reloadData()
            }
            self.present(controller, animated: true, completion: nil)
        }
        deleteAction.image = Utils.resizeImage(image: UIImage(named: "ic_delete")!, targetSize: CGSize(width: 20.0, height: 20.0))
        deleteAction.backgroundColor = UIColor.white
        return [deleteAction]
    }
}

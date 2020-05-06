//
//  StoryPublishVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/30/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol StoryPublishVCDelegate {
    func doneStory()
}

class StoryPublishVC: UIViewController {

    @IBOutlet weak var view_overlay: UIView!
    @IBOutlet weak var view_tag: UIView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var img_photo: UIImageView!
    @IBOutlet weak var img_story: UIImageView!
    @IBOutlet weak var constraintTagHeight: NSLayoutConstraint!
    
    var delegate:StoryPublishVCDelegate!
    
    var photofile: UIImage!
    var hud: JGProgressHUD!
    
    var tag_users:[User] = []
    var all_users:[User] = []
    var selected_users:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setViewController(){
        txt_search.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        view_overlay.isHidden = true
        
        lb_name.text = AppData.user.username
        if AppData.user.photo_url.isEmpty {
            img_photo.image = UIImage(named: "default_avata")
        } else {
            if AppData.user.photo_url.contains("http") {
                img_photo.sd_setImage(with: URL(string: AppData.user.photo_url), placeholderImage: nil)
            } else{
                img_photo.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + AppData.user.photo_url), placeholderImage: nil)
            }
        }
        
        img_story.image = photofile
        getAllUsers()
    }
    
    func getAllUsers(){
        API.getAllUsers( onSuccess: {response in
            self.all_users = response
            self.tag_users = response
        }, onFailed: { err in
            self.showToast(message: err)
        })
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        searchUsers(keyword: txt_search.text!)
    }
    
    func searchUsers(keyword: String){
        if keyword.count > 0 {
            tag_users = all_users.filter{
                $0.username.lowercased().contains(keyword.lowercased())
                
            }
        } else{
            tag_users.removeAll()
            tag_users = all_users
        }
        
        table_view.reloadData()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickTag(_ sender: Any) {
        view_overlay.isHidden = false
        constraintTagHeight.constant = 0.0
        UIView.animate(withDuration: 0.6, animations: {
            self.constraintTagHeight.constant = 380.0
        }, completion: {result in
            self.view_tag.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
            self.txt_search.text = ""
            self.searchUsers(keyword: "")
        })
    }
    
    @IBAction func onClickPublish(_ sender: Any) {
        let file_name = "story_" + AppData.user.id + "_\(Int64(Date().timeIntervalSince1970))"
        hud.show(in: view)
        API.uploadStory(name: file_name, image: UIImagePNGRepresentation(photofile!)!, onSuccess: {response in
            let story = Story.init()
            story.image = response
            story.timebeg = Int64(Date().timeIntervalSince1970)
            story.timeend = story.timebeg + 86400
            story.user = AppData.user
            story.tags = self.getTaggedStr()
            API.saveStory(story: story, onSuccess: {response in
                self.hud.dismiss()
                self.actionBack(completion: {
                    if self.delegate != nil {
                        self.delegate.doneStory()
                    }
                })
            }, onFailed: { error in
                self.hud.dismiss()
                self.showToast(message: error)
            })
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }
    
    @IBAction func onClickOutside(_ sender: Any) {
        view_overlay.isHidden = true
    }
    
    @IBAction func onClickDown(_ sender: Any) {
        view_overlay.isHidden = true
    }
    
    @IBAction func onClickSearchCancel(_ sender: Any) {
        self.txt_search.text = ""
        self.searchUsers(keyword: "")
    }
    
    func getTaggedStr()->String!{
        var tag_str = ""
        for uu in selected_users {
            if tag_str.count == 0{
                tag_str = uu.id
            } else {
                tag_str = tag_str + "," + uu.id
            }
        }
        return tag_str
    }
    
}

extension StoryPublishVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tag_users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = tag_users[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PublishTagUserTVC", for: indexPath) as! PublishTagUserTVC
        cell.index = indexPath.row
        cell.delegate = self
        if let foo = selected_users.firstIndex(where: {$0.id == user.id}){
            cell.setCell(user: user, bSel: true)
        } else {
            cell.setCell(user: user, bSel: false)
        }
        return cell
    }
}

extension StoryPublishVC:PublishTagUserTVCDelegate{
    func onSelect(ind: Int){
        let user = tag_users[ind]
        if let foo = selected_users.firstIndex(where: {$0.id == user.id}) {
            selected_users.remove(at: foo)
        } else {
            selected_users.append(user)
        }
        table_view.reloadData()
    }
}

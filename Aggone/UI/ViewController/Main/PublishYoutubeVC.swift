//
//  PublishYoutubeVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/29/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import YouTubePlayer
import JGProgressHUD

protocol PublishYoutubeVCDelegate {
    func doneYoutube()
}

class PublishYoutubeVC: UIViewController {
    
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var lb_publish: UILabel!
    @IBOutlet weak var youtube_view: YouTubePlayerView!
    @IBOutlet weak var view_overlay: UIView!
    @IBOutlet weak var view_tag: UIView!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var constraintTagHeight: NSLayoutConstraint!
    @IBOutlet weak var txt_search: UITextField!
    
    var delegate:PublishYoutubeVCDelegate!
    
    var video_title: String!
    var video: YoutubeVideoInfo!
    var nPublic: Int = Constants.FEED_PUBLIC
    var hud: JGProgressHUD!
    
    var tag_users:[User] = []
    var all_users:[User] = []
    var selected_users:[User] = []
    var desc_str: String! = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.all, andRotateTo: .portrait)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    func setViewController() {
        txt_search.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        view_overlay.isHidden = true
        
        label_title.text = video_title
        youtube_view.loadVideoID(video.id)
        
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
    
    @IBAction func onClickdescription(_ sender: Any) {
        let controller : ReportDialog = ReportDialog.init(nibName: "ReportDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.setTitle(text: "Description")
        present(controller, animated: true, completion: nil)
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
    
    @IBAction func onClickPrivate(_ sender: Any) {
        if nPublic == Constants.FEED_PUBLIC {
            nPublic = Constants.FEED_PRIVATE
            showToast(message: "This video is private")
        } else {
            nPublic = Constants.FEED_PUBLIC
            showToast(message: "This video is public")
        }
    }
    
    @IBAction func onClickPublish(_ sender: Any) {
        let feed:Feed = Feed.init()
        feed.type = Constants.YOUTUBE
        feed.user = AppData.user
        feed.sport = AppData.user.sport
        feed.title = video_title
        feed.video_url = video.id
        feed.thumbnail_url = video.thumbnailUrl
        feed.like_count = 0
        feed.view_count = 0
        feed.timestamp = Int64(Date().timeIntervalSince1970)
        feed.shared = 1
        feed.desc_str = desc_str
        feed.mode = nPublic
        feed.tagged = getTaggedStr()
        
        hud.show(in: view)
        API.saveFeed(feed: feed, onSuccess: ({ _ in
            self.hud.dismiss()
            self.actionBack(completion: {
                if self.delegate != nil {
                    self.delegate.doneYoutube()
                }
            })
        }), onFailed: ({ error in
            self.showToast(message: error)
            self.hud.dismiss()
        }))
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
    
    @IBAction func onClickOutside(_ sender: Any) {
        view_overlay.isHidden = true
    }
    
    @IBAction func onClickDownTag(_ sender: Any) {
        view_overlay.isHidden = true
    }
    
    @IBAction func onSearchCancel(_ sender: Any) {
        self.txt_search.text = ""
        self.searchUsers(keyword: "")
    }
    
}

extension PublishYoutubeVC: UITableViewDelegate, UITableViewDataSource {
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

extension PublishYoutubeVC:PublishTagUserTVCDelegate{
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

extension PublishYoutubeVC: ReportDialogDelegate {
    func onClickOk(text: String) {
        desc_str = text
    }
}

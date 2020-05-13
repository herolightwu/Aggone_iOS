//
//  PublishVideoVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/29/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import JGProgressHUD

protocol PublishVideoVCDelegate {
    func doneVideo()
}

class PublishVideoVC: UIViewController {

    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var view_video: UIView!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var view_tag: UIView!
    @IBOutlet weak var view_overlay: UIView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var constraintTagHeight: NSLayoutConstraint!
    
    var playerController: AVPlayerViewController!
    
    var delegate:PublishVideoVCDelegate!
    
    var video_url: URL!
    var video_title: String!
    var video:Data!
    
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
        
        for subview in view_video.subviews {
            subview.removeFromSuperview()
        }
        let videoURL = URL(string: video_url.absoluteString)
        let player = AVPlayer(url: videoURL! as URL)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.view.frame = view_video.bounds
        view_video.addSubview(playerController.view)
        
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
    
    @IBAction func onClickPublish(_ sender: Any) {
        do {
            video = try Data(contentsOf: self.video_url)
            let thumbnail = self.getThumbnailFromVideoURL(url: self.video_url)
            let file_name:String = "video_" + AppData.user.id + "\(UInt(Date().timeIntervalSince1970))"
            hud.show(in: view)
            API.uploadFile(name: file_name, video: video, thumbnail: UIImagePNGRepresentation(thumbnail!)!, onSuccess: ({ video_url, thumbnail_url  in
                
                let feed:Feed = Feed.init()
                feed.type = Constants.NORMAL
                feed.user = AppData.user
                feed.sport = AppData.user.sport
                feed.title = self.video_title
                feed.video_url = video_url
                feed.thumbnail_url = thumbnail_url
                feed.like_count = 0
                feed.view_count = 0
                feed.timestamp = Int64(Date().timeIntervalSince1970)
                feed.shared = 1
                feed.desc_str = self.desc_str
                feed.mode = self.nPublic
                feed.tagged = self.getTaggedStr()
                
                API.saveFeed(feed: feed, onSuccess: ({ _ in
                    self.hud.dismiss()
                    self.actionBack(completion: {
                        if self.delegate != nil {
                            self.delegate.doneVideo()
                        }
                    })
                }), onFailed: ({ error in
                    self.showToast(message: error)
                    self.hud.dismiss()
                }))
                
            }), onFailed: ({ error in
                self.showToast(message: error)
                self.hud.dismiss()
            }))
        } catch {
            self.showToast(message: "Something went wrong")
        }
    }
    
    @IBAction func onClickDescription(_ sender: Any) {
        let controller : ReportDialog = ReportDialog.init(nibName: "ReportDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.setTitle(text: "Description")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickTagged(_ sender: Any) {
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
    
    @IBAction func onClickOutside(_ sender: Any) {
        view_overlay.isHidden = true
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.txt_search.text = ""
        self.searchUsers(keyword: "")
    }
    
    @IBAction func onClickDown(_ sender: Any) {
        view_overlay.isHidden = true
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

extension PublishVideoVC: UITableViewDelegate, UITableViewDataSource {
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

extension PublishVideoVC:PublishTagUserTVCDelegate{
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

extension PublishVideoVC: ReportDialogDelegate {
    func onClickOk(text: String) {
        desc_str = text
    }
}

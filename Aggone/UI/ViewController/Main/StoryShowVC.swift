//
//  StoryShowVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/30/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import LinearProgressBar
import JGProgressHUD

class StoryShowVC: UIViewController {
    
    @IBOutlet weak var img_photo: UIImageView!
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var lb_resttime: UILabel!
    @IBOutlet weak var img_story: UIImageView!
    @IBOutlet weak var linearProgressBar: LinearProgressBar!
    @IBOutlet weak var view_other: UIView!
    @IBOutlet weak var view_edit: UIView!
    @IBOutlet weak var txt_reply: UITextField!
    @IBOutlet weak var view_self: UIView!
    @IBOutlet weak var lb_viewcount: UILabel!
    @IBOutlet weak var view_msg: UIView!
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var view_mask: UIView!
    @IBOutlet weak var view_delete: UIView!
    
    var hud: JGProgressHUD!
    var user: User!
    var all_story:[Story] = []
    
    var story:Story!
    var cur_num: Int! = 0
    var bStop: Bool! = true
    var nCount:Int! = 0
    var nMax:Int! = 150
    
    
    var smsgs:[StoryMsg] = []
    var st_views:[StoryView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
    }
    
    func setViewController(){
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        txt_reply.delegate = self
        
        view_edit.layer.borderWidth = 2
        view_edit.layer.masksToBounds = false
        view_edit.layer.borderColor = UIColor.white.cgColor
        view_edit.layer.cornerRadius = view_edit.frame.height/2
        view_edit.clipsToBounds = true
        
        if user.id == AppData.user.id {
            view_other.isHidden = true
            view_self.isHidden = false
            view_msg.isHidden = true
            view_mask.isHidden = true
        } else{
            view_other.isHidden = false
            view_self.isHidden = true
            
        }
        
        if !user.photo_url.isEmpty {
            if user.photo_url.contains("http") {
                img_photo.sd_setImage(with: URL(string:user.photo_url), placeholderImage: nil)
            } else{
                img_photo.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + user.photo_url), placeholderImage: nil)
            }
        }
        
        lb_name.text = user.username
        lb_resttime.text = ""
        
        getStories()
        
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    @objc func fire()
    {
        if !bStop {
            if nCount < nMax {
                linearProgressBar.progressValue = CGFloat(nCount)*100/CGFloat(nMax)
                if nCount % 150 == 0 {
                    let nInd = nCount / 150
                    story = all_story[nInd]
                    img_story.sd_setImage(with: URL(string:API.baseUrl + API.storyDirUrl + story.image), placeholderImage: nil)
                    lb_resttime.text = getRestTime()
                    
                    if user.id == AppData.user.id{
                        getStoryViews()
                        view_other.isHidden = true
                        view_self.isHidden = false
                        view_msg.isHidden = true
                        view_mask.isHidden = true
                    } else{
                        setViewStory()
                        view_other.isHidden = false
                        view_self.isHidden = true
                    }
                }
                nCount += 1
            } else {
                self.actionBack()
            }
        }
    }
    
    func setViewStory(){
        bStop = true
        hud.show(in: view)
        API.viewStory(sid: story.id, onSuccess: { response in
            self.hud.dismiss()
            self.bStop = false
        }, onFailed: { err in
            self.hud.dismiss()
            self.bStop = false
        })
    }
    
    func getStoryViews(){
        bStop = true
        lb_viewcount.text = ""
        hud.show(in: view)
        API.getStoryViews(sid: story.id, onSuccess: { response in
            self.hud.dismiss()
            let vcount = response.1
            let sviews = response.0
            self.lb_viewcount.text = "\(vcount) views"
            self.st_views.removeAll()
            self.st_views = sviews
            self.collection_view.reloadData()
            self.bStop = false
        }, onFailed: {err in
            self.hud.dismiss()
            self.bStop = false
        })
    }
    
    func getRestTime()->String!{
        var rest_time = "";
        let diff = story.timeend - Int64(Date().timeIntervalSince1970)
        if (diff < 60){
            rest_time = String(diff) + "s";
        } else if(diff < 3600){
            rest_time = String(Int(diff/60)) + "m";
        } else{
            rest_time = String(Int(diff/3600)) + "h";
        }
        return rest_time;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getStories(){
        hud.show(in: view)
        API.getStoriesByUser(uid: user.id, onSuccess: { response in
            self.hud.dismiss()
            if response.count > 0 {
                self.all_story = response
                self.bStop = false
                self.nMax = 150 * response.count
            } else {
                self.actionBack()
            }
        }, onFailed: { err in
            self.hud.dismiss()
            self.actionBack()
        })
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickReport(_ sender: Any) {
        let controller : ReportDialog = ReportDialog.init(nibName: "ReportDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.setTitle(text: "Report")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        bStop = true
        view_mask.isHidden = false
        self.view_delete.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
    }
    
    @IBAction func onClickMsgDown(_ sender: Any) {
        view_msg.isHidden = true
    }
    
    @IBAction func onClickDelete(_ sender: Any) {
        let controller : DeleteDialog = DeleteDialog.init(nibName: "DeleteDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.handler = { () in
            self.hud.show(in: self.view)
            API.deleteStory(sid: self.story.id, onSuccess: { response in
                self.hud.dismiss()
                self.bStop = false
                self.nCount = Int((self.nCount + 150)/150)
            }, onFailed: { err in
                self.hud.dismiss()
                self.showToast(message: err)
                self.bStop = false
            })
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickOutside(_ sender: Any) {
        view_mask.isHidden = true
        bStop = false
    }
    
    func sendReplyToStory(text: String){
        hud.show(in: view)
        API.replyStory(sid: story.id, type: Constants.REPLY_TYPE_TEXT, msg: text, onSuccess: { response in
            self.hud.dismiss()
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }
    
    func getStoryMsg(user: User!){
        bStop = true
        hud.show(in: view)
        API.getStoryMsg(sid: story.id, uid: user.id, onSuccess: { response in
            self.hud.dismiss()
            self.smsgs = response
            self.table_view.reloadData()
            self.view_msg.isHidden = false
            self.bStop = false
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
            self.bStop = false
        })
    }
}

extension StoryShowVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return st_views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryViewUserCVC", for: indexPath) as! StoryViewUserCVC
        cell.setCell(stv: st_views[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if st_views[indexPath.row].reply_count > 0 {
            getStoryMsg(user: st_views[indexPath.row].user)
        }
    }
}

extension StoryShowVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
}

extension StoryShowVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smsgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryMsgTVC", for: indexPath) as! StoryMsgTVC
        cell.setCell(sm: smsgs[indexPath.row])
        return cell
    }
}

extension StoryShowVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        showToast(message: "return pressed")
        sendReplyToStory(text: txt_reply.text!)
        txt_reply.text = ""
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bStop = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        bStop = false
    }
}

extension StoryShowVC: ReportDialogDelegate {
    func onClickOk(text: String) {
        hud.show(in: view)
        API.reportStory(sid: story.id, content: text, onSuccess: { response in
            self.hud.dismiss()
            self.showToast(message: "Your report was sent to manager successful")
            self.bStop = false
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
            self.bStop = false
        })
    }
}

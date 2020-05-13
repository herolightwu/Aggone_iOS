//
//  SearchViewController.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/13/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class SearchViewController: UIViewController {
    @IBOutlet weak var people_table: UITableView!
    @IBOutlet weak var video_table: UITableView!
    @IBOutlet weak var et_search: UITextField!
    @IBOutlet weak var lb_people: UILabel!
    @IBOutlet weak var lb_video: UILabel!
    
    var bPeople: Bool! = true
    var users: [User] = []
    var feeds: [Feed] = []
    
    var report_sel: Int = -1
    var hud:JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        et_search.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        lb_people.text = getString(key: "txt_people")
        lb_video.text = getString(key: "txt_video")
        refreshView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshView(){
        if bPeople {
            lb_people.textColor = UIColor.from(hex: "#B8DB68")
            lb_video.textColor = UIColor.from(hex: "#929292")
            people_table.isHidden = false
            video_table.isHidden = true
        } else{
            lb_people.textColor = UIColor.from(hex: "#929292")
            lb_video.textColor = UIColor.from(hex: "#B8DB68")
            people_table.isHidden = true
            video_table.isHidden = false
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if et_search.text!.count > 1 {
            if bPeople {
                searchUsers(keyword: et_search.text!)
            } else{
                searchFeeds(keyword: et_search.text!)
            }
//            refreshView()
        }
    }
    
    func searchUsers(keyword: String){
        API.searchUsers(keyword: keyword, onSuccess: {response in
            self.users = response
            self.people_table.reloadData()
        }, onFailed: {err in
            self.showToast(message: err)
        })
    }
    
    func searchFeeds(keyword: String){
        API.searchVideoFeeds(keyword: keyword, onSuccess: {response in
            self.feeds = response
            self.video_table.reloadData()
        }, onFailed: {err in
            self.showToast(message: err)
        })
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        et_search.text = ""
        users.removeAll()
        feeds.removeAll()
        people_table.reloadData()
        video_table.reloadData()
    }
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickPeople(_ sender: Any) {
        bPeople = true
        et_search.text = ""
        refreshView()
    }
    @IBAction func onClickVideo(_ sender: Any) {
        bPeople = false
        et_search.text = ""
        refreshView()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == people_table {
            return users.count
        } else if tableView == video_table {
            return feeds.count
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == people_table {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaggedUserViewCell", for: indexPath) as! TaggedUserViewCell
            cell.index = indexPath.row
            cell.delegate = self
            cell.setCell(user: users[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedViewCell", for: indexPath) as! NewsFeedViewCell
            cell.index = indexPath.row
            cell.delegate = self
            cell.setCell(feed: feeds[indexPath.row])
            return cell
        }
    }
    
}

extension SearchViewController: NewsFeedCellDelegate {
    func onClickProfile(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = feeds[index].user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onClickPlay(index: Int) {
        let feed = feeds[index]
        API.addViewFeed(feed: feed, onSuccess: { response in
            self.feeds[index].view_count = response.view_count
            if feed.type == Constants.YOUTUBE {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
                controller.video_title = self.feeds[index].title
                controller.video_url = self.feeds[index].video_url
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
                controller.video_title = self.feeds[index].title
                controller.video_url = self.feeds[index].video_url
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }, onFailed: { err in
            self.showToast(message: err)
        })
    }
    
    func onClickBookmark(index: Int) {
        API.saveBookmark(feed_id: feeds[index].id, onSuccess: { response in
            self.showToast(message: "Success")
            self.feeds[index].bookmark = response
            self.video_table.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
    
    func onClickMenu(index: Int) {
        report_sel = index
        let controller : ReportDialog = ReportDialog.init(nibName: "ReportDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.setTitle(text: "Report")
        present(controller, animated: true, completion: nil)
    }
    
    func onClickLike(index: Int) {
        API.addLikeFeed(feed: feeds[index], user: AppData.user, onSuccess: ({result in
            if result == true {
                self.feeds[index].like_count = self.feeds[index].like_count + 1
                self.feeds[index].like = true
            } else {
                self.feeds[index].like_count = self.feeds[index].like_count - 1
                self.feeds[index].like = false
            }
            self.video_table.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }), onFailed: ({error in
            self.showToast(message: error)
        }))
    }
    
    func onClickTagged(index: Int) {
        
    }
    
    func onClickArticle(index: Int) {
        let feed = feeds[index]
        if feed.type == Constants.NEWS {
            API.addViewFeed(feed: feed, onSuccess: { response in
                self.feeds[index].view_count = response.view_count
                //show Articles
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
                controller.feed = self.feeds[index]
                self.navigationController?.pushViewController(controller, animated: true)
            }, onFailed: { err in
                self.showToast(message: err)
            })
        }
    }
}

extension SearchViewController:TaggedUserViewCellDelegate{
    func onClickProfileBtn(index: Int){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = users[index]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: ReportDialogDelegate {
    func onClickOk(text: String) {
        if report_sel != -1 {
            hud.show(in: view)
            API.reportFeed(fid: feeds[report_sel].id, content: text, onSuccess: { response in
                self.hud.dismiss()
                self.showToast(message: "Your report was sent to manager successful")
            }, onFailed: { err in
                self.hud.dismiss()
                self.showToast(message: err)
            })
            report_sel = -1
        }
    }
}

// Put this piece of code anywhere you like
extension SearchViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


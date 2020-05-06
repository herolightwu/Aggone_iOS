//
//  RecordedViewController.swift
//  Aggone
//
//  Created by APPLE on 2019/4/4.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class RecordedViewController: UIViewController {

    @IBOutlet weak var table_view: UITableView!
    let refreshControl = UIRefreshControl()
    var feeds:[Feed] = []
    
    var user: User!
    var hud:JGProgressHUD!
    var report_sel: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    func setViewController() {
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        table_view.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    @objc func refresh() {
        API.getBookmarks(user_id: user.id, onSuccess: { response in
            self.feeds = response
            self.table_view.reloadData()
            self.refreshControl.endRefreshing()
        }, onFailed: { error in
            self.showToast(message: error)
            self.refreshControl.endRefreshing()
        })
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        actionBack()
    }
}

extension RecordedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedViewCell", for: indexPath) as! NewsFeedViewCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(feed: feeds[indexPath.row])
        return cell
    }
}

extension RecordedViewController: NewsFeedCellDelegate {
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
            self.table_view.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            self.refreshControl.beginRefreshing()
            self.refreshControl.sendActions(for: .valueChanged)
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
            self.table_view.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
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

extension RecordedViewController: ReportDialogDelegate {
    func onClickOk(text: String) {
        if report_sel != -1 {
            hud.show(in: view)
            API.reportFeed(fid: feeds[report_sel].id, content: text, onSuccess: { response in
                self.hud.dismiss()
                self.refreshControl.beginRefreshing()
                self.refreshControl.sendActions(for: .valueChanged)
                self.showToast(message: "Your report was sent to manager successful")
            }, onFailed: { err in
                self.hud.dismiss()
                self.showToast(message: err)
            })
            report_sel = -1
        }
    }
}

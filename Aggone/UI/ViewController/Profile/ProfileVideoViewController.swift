//
//  ProfileVideoViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/28/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import DropDown
import AVKit
import MobileCoreServices
import FirebaseDatabase
import JGProgressHUD

class ProfileVideoViewController: UIViewController {

    @IBOutlet var table_view: UITableView!
    
    var parentVC: ProfileViewController!
    let refreshControl = UIRefreshControl()
    var user:User!
    var feeds:[Feed] = []
    var page: Int = 1
    var report_sel: Int = -1
    
    var hud: JGProgressHUD!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud = JGProgressHUD(style: .dark)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        table_view.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }

    @objc func refresh() {
        page = 1
        API.getAllFeedsByUserid(page: page, user_id: user.id, onSuccess: { feeds in
            self.feeds.removeAll()
            self.feeds = feeds
            self.table_view.reloadData()
            self.refreshControl.endRefreshing()
        }, onFailed: { error in
            self.showToast(message: error)
            self.refreshControl.endRefreshing()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ProfileVideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileVideoTableViewCell", for: indexPath) as! ProfileVideoTableViewCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(feed: feeds[indexPath.row])
        return cell
    }
    
}

extension ProfileVideoViewController: ProfileVideoCellDelegate {
    func onClickDelete(index: Int) {
        let controller : DeleteDialog = DeleteDialog.init(nibName: "DeleteDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.handler = { () in
            API.deleteFeed(feed_id: self.feeds[index].id, onSuccess: { response in
                self.feeds.remove(at: index)
                self.table_view.reloadData()
            }, onFailed: { error in
                self.showToast(message: error)
            })
        }
        present(controller, animated: true, completion: nil)
    }
    
    func onClickBookmark(index: Int) {
        API.saveBookmark(feed_id: feeds[index].id, onSuccess: { response in
            self.showToast(message: "Success")
            self.feeds[index].bookmark = response
            self.table_view.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }, onFailed: { error in
            self.showToast(message: error)
        })
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
                self.parentVC.navigationController?.pushViewController(controller, animated: true)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
                controller.video_title = self.feeds[index].title
                controller.video_url = self.feeds[index].video_url
                self.parentVC.navigationController?.pushViewController(controller, animated: true)
            }
        }, onFailed: { err in
            self.showToast(message: err)
        })
        
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
        
    func onClickReport(index: Int) {
        report_sel = index
        let controller : ReportDialog = ReportDialog.init(nibName: "ReportDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.setTitle(text: "Report")
        present(controller, animated: true, completion: nil)
    }
    
    func onClickArticle(index: Int) {
        let feed = feeds[index]
        if feed.type == Constants.NEWS {
            //show Articles
            API.addViewFeed(feed: feed, onSuccess: { response in
                self.feeds[index].view_count = response.view_count
                //show Articles
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
                controller.feed = self.feeds[index]
                self.parentVC.navigationController?.pushViewController(controller, animated: true)
            }, onFailed: { err in
                self.showToast(message: err)
            })
        }
    }
    
    func onClickPrivate(index: Int) {
        var bPrivate = true
        if feeds[index].mode == Constants.FEED_PRIVATE {
            bPrivate = false
        }
        hud.show(in: view)
        API.privateFeed(feed_id: feeds[index].id, flag: bPrivate, onSuccess: { response in
            self.hud.dismiss()
            self.feeds[index].mode = Constants.FEED_PRIVATE
            if !response {
                self.feeds[index].mode = Constants.FEED_PUBLIC
            }
        }, onFailed: {err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }
}

extension ProfileVideoViewController: ReportDialogDelegate {
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

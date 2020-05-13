//
//  ProfileVideoTableViewCell.swift
//  Aggone
//
//  Created by tiexiong on 5/28/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import YouTubePlayer
import DropDown

protocol ProfileVideoCellDelegate {
    func onClickBookmark(index: Int)
    func onClickPlay(index: Int)
    func onClickLike(index: Int)
    func onClickDelete(index: Int)
    func onClickArticle(index: Int)
    func onClickReport(index: Int)
    func onClickPrivate(index: Int)
}

class ProfileVideoTableViewCell: UITableViewCell {

    @IBOutlet var label_title: UILabel!
    @IBOutlet weak var label_view_count: UILabel!
    @IBOutlet var label_like_count: UILabel!
    @IBOutlet weak var label_time: UILabel!
    @IBOutlet weak var image_thumbnail: UIImageView!
    @IBOutlet weak var image_like: UIImageView!
    @IBOutlet weak var image_bookmark: UIImageView!
    @IBOutlet weak var btn_menu: UIButton!
    @IBOutlet weak var btn_report: UIButton!
    @IBOutlet weak var lb_desc: UILabel!
    @IBOutlet weak var btn_play: UIButton!
    @IBOutlet weak var btn_article: UIButton!
    
    var index:Int!
    var delegate: ProfileVideoCellDelegate!
    var dd_menu : DropDown!
    var mode: Int = Constants.FEED_PUBLIC
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image_thumbnail.layer.cornerRadius = 10
        image_thumbnail.clipsToBounds = true
    }
    func setCell(feed:Feed) {
        if feed.user.id == AppData.user.id {
            btn_menu.isHidden = false
            btn_report.isHidden = true
        } else {
            btn_menu.isHidden = true
            btn_report.isHidden = false
        }
        if feed.type == Constants.NEWS {
            btn_play.isHidden = true
            btn_article.isHidden = false
            if !feed.articles.isEmpty {
                let art_path = feed.articles.components(separatedBy: ",")
                if art_path[0].contains("http"){
                    image_thumbnail.sd_setImage(with: URL(string: art_path[0]), placeholderImage: nil)
                } else {
                    image_thumbnail.sd_setImage(with: URL(string: API.baseUrl + API.articleDirUrl + art_path[0]), placeholderImage: nil)
                }
            }
        } else {
            btn_play.isHidden = false
            btn_article.isHidden = true
            if feed.thumbnail_url.contains("http"){
                image_thumbnail.sd_setImage(with: URL(string: feed.thumbnail_url), placeholderImage: nil)
            } else {
                image_thumbnail.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + feed.thumbnail_url), placeholderImage: nil)
            }
        }
        label_title.text = feed.title
        lb_desc.text = feed.desc_str
        label_view_count.text = "\(feed.view_count)"
        label_like_count.text = "\(feed.like_count)"
        if feed.like {
            image_like.image = UIImage(named: "main_like_active")
        } else {
            image_like.image = UIImage(named: "main_like_normal")
        }
        if feed.bookmark {
            image_bookmark.image = UIImage(named: "main_bookmark_active")
        } else {
            image_bookmark.image = UIImage(named: "main_bookmark_normal")
        }
        let delta = Int64(Date().timeIntervalSince1970) - feed.timestamp
        if Utils.deltaTimeString(delta: delta).isEmpty {
            let date = Date(timeIntervalSince1970: TimeInterval(feed.timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            label_time.text = dateFormatter.string(from: date)
        } else {
            label_time.text = Utils.deltaTimeString(delta: delta)
        }
        if feed.mode == Constants.FEED_PRIVATE {
            mode = Constants.FEED_PRIVATE
        }
    }
    
    @IBAction func onClickLike(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onClickLike(index: self.index)
        }
    }
    
    @IBAction func onClickBookmark(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onClickBookmark(index: self.index)
        }
    }
    
    @IBAction func onClickPlay(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onClickPlay(index: self.index)
        }
    }
    
    @IBAction func onClickReport(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onClickReport(index: self.index)
        }
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        dd_menu = DropDown()
        dd_menu.anchorView = btn_menu
        dd_menu.direction = .any
        if mode == Constants.FEED_PUBLIC {
            dd_menu.localizationKeysDataSource = ["Make Private", "Delete"]
        } else{
            dd_menu.localizationKeysDataSource = ["Make Public", "Delete"]
        }
        
        dd_menu.selectionAction = { [unowned self] (sel_index: Int, item: String) in
            if self.delegate != nil {
                if sel_index == 0 {
                    self.delegate.onClickPrivate(index: self.index)
                } else{
                    self.delegate.onClickDelete(index: self.index)
                }
                
            }
        }
        dd_menu.show()
    }
    
    @IBAction func onClickArticle(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.onClickArticle(index: self.index)
        }
    }
    
}

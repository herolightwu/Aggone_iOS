//
//  NewsFeedViewCell.swift
//  Aggone
//
//  Created by tiexiong on 5/22/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SDWebImage
import YouTubePlayer

protocol NewsFeedCellDelegate {
    func onClickMenu(index: Int)
    func onClickLike(index: Int)
    func onClickProfile(index: Int)
    func onClickPlay(index: Int)
    func onClickBookmark(index: Int)
    func onClickTagged(index: Int)
    func onClickArticle(index: Int)
}

class NewsFeedViewCell: UITableViewCell {

    @IBOutlet var image_photo: UIImageView!
    @IBOutlet var label_username: UILabel!
    @IBOutlet var label_title: UILabel!
    @IBOutlet weak var label_desc: UILabel!
    @IBOutlet var label_like_count: UILabel!
    @IBOutlet weak var label_view_count: UILabel!
    @IBOutlet weak var image_thumbnail: UIImageView!
    @IBOutlet weak var label_time: UILabel!
    @IBOutlet weak var image_like: UIImageView!
    @IBOutlet weak var image_bookmark: UIImageView!
    @IBOutlet weak var tag_view: UIView!
    @IBOutlet weak var btn_play: UIButton!
    @IBOutlet weak var btn_article: UIButton!
    
    var index: Int!
    var delegate: NewsFeedCellDelegate!
    var playerController: AVPlayerViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image_photo.layer.cornerRadius = image_photo.frame.size.height / 2
        image_photo.clipsToBounds = true
        image_thumbnail.layer.cornerRadius = 10
        image_thumbnail.clipsToBounds = true
        
        btn_article.isExclusiveTouch = true
        btn_play.isExclusiveTouch = true
    }

    func setCell(feed:Feed) {
        btn_play.isEnabled = true;
        btn_article.isEnabled = true;
        if feed.user.photo_url.isEmpty {
            image_photo.image = UIImage(named: "default_avata")
        } else {
            if feed.user.photo_url.contains("http") {
                image_photo.sd_setImage(with: URL(string: feed.user.photo_url), placeholderImage: nil)
            } else{
                image_photo.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + feed.user.photo_url), placeholderImage: nil)
            }
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
        
        label_username.text = feed.user.username
        label_title.text = feed.title
        label_desc.text = feed.desc_str
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
        } else{
            label_time.text = Utils.deltaTimeString(delta: delta)
        }
        
        if feed.tagged.isEmpty {
            tag_view.isHidden = true
        } else{
            tag_view.isHidden = false
        }
        
    }

    @IBAction func onClickMenu(_ sender: Any) {
        if self.delegate != nil {
            delegate.onClickMenu(index: self.index)
        }
    }
    
    @IBAction func onClickLike(_ sender: Any) {
        if self.delegate != nil {
            delegate.onClickLike(index: self.index)
        }
    }
    
    @IBAction func onClickPhoto(_ sender: Any) {
        if self.delegate != nil {
            delegate.onClickProfile(index: self.index)
        }
    }
    
    @IBAction func onClickPlay(_ sender: Any) {
        if self.delegate != nil {
            delegate.onClickPlay(index: self.index)
            btn_play.isEnabled = false
        }
    }
    
    @IBAction func onClickBookmark(_ sender: Any) {
        if self.delegate != nil {
            delegate.onClickBookmark(index: self.index)
        }
    }
    
    @IBAction func onClickTagged(_ sender: Any) {
        if self.delegate != nil {
            delegate.onClickTagged(index: self.index)
        }
    }
    @IBAction func onClickArticle(_ sender: Any) {
        if self.delegate != nil {
            delegate.onClickArticle(index: self.index)
            btn_article.isEnabled = false
        }
    }
}

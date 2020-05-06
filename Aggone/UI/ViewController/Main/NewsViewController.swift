//
//  NewsViewController.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/18/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var lb_news: UILabel!
    @IBOutlet weak var img_article: UIImageView!
    @IBOutlet weak var btn_forword: UIButton!
    @IBOutlet weak var btn_backword: UIButton!
    @IBOutlet weak var img_photo: UIImageView!
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var lb_time: UILabel!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var tv_desc: UITextView!
    
    var feed: Feed!
    var paths: [String] = []
    var page_num: Int = 0
    var page_max: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lb_news.text = getString(key: "txt_news")
        if !feed.articles.isEmpty{
            paths = feed.articles.components(separatedBy: ",")
            page_max = paths.count
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        
        if feed.user.photo_url.isEmpty {
            img_photo.image = UIImage(named: "default_avata")
        } else {
            if feed.user.photo_url.contains("http") {
                img_photo.sd_setImage(with: URL(string: feed.user.photo_url), placeholderImage: nil)
            } else{
                img_photo.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + feed.user.photo_url), placeholderImage: nil)
            }
        }
        lb_name.text = feed.user.username
        let delta = Int64(Date().timeIntervalSince1970) - feed.timestamp
        if Utils.deltaTimeString(delta: delta).isEmpty {
            let date = Date(timeIntervalSince1970: TimeInterval(feed.timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            lb_time.text = dateFormatter.string(from: date)
        }
        
        lb_title.text = feed.title
        tv_desc.text = feed.desc_str
        refreshButton()
        refreshArticle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshButton(){
        btn_backword.isHidden = true
        if page_num > 0 {
            btn_backword.isHidden = false
        }
        if page_max > 1 {
            if page_num == page_max - 1 {
                btn_forword.isHidden = false
            } else{
                btn_forword.isHidden = true
            }
            
        } else {
            btn_forword.isHidden = true
        }
    }
    
    func refreshArticle(){
        if !paths[page_num].isEmpty {
            if paths[page_num].contains("http"){
                img_article.sd_setImage(with: URL(string: paths[page_num]), placeholderImage: nil)
            } else{
                img_article.sd_setImage(with: URL(string: API.baseUrl + API.articleDirUrl + paths[page_num]), placeholderImage: nil)
            }
        } else {
            img_article.image = nil
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickBackword(_ sender: Any) {
        page_num -= 1
        refreshButton()
        refreshArticle()
    }
    
    @IBAction func onClickForword(_ sender: Any) {
        page_num += 1
        refreshButton()
        refreshArticle();
    }
}

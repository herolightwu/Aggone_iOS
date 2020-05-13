//
//  AddDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol AddDialogDelegate {
    func onClickUploadVideo()
    func onClickAddPrize()
    func onClickCareerRoadmap()
    func onClickAddDescription()
    func onClickRemove()
    func onClickAddNews()
    func onClickAddHistory()
    
}

class AddDialog: UIViewController {
    
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var view_upload_video: UIView!
    @IBOutlet weak var view_add_prize: UIView!
    @IBOutlet weak var view_career_roadmap: UIView!
    @IBOutlet weak var view_add_description: UIView!
    @IBOutlet weak var view_others: UIView!
    @IBOutlet weak var view_add_news: UIView!
    @IBOutlet weak var view_add_history: UIView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    @IBOutlet weak var lb_news_title: UILabel!
    @IBOutlet weak var lb_news_desc: UILabel!
    @IBOutlet weak var lb_history_title: UILabel!
    @IBOutlet weak var lb_history_desc: UILabel!
    
    
    var delegate : AddDialogDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true
        
        view_upload_video.layer.cornerRadius = 12
        view_upload_video.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        view_upload_video.layer.borderWidth = 1
        view_upload_video.clipsToBounds = true
        
        view_add_prize.layer.cornerRadius = 12
        view_add_prize.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        view_add_prize.layer.borderWidth = 1
        view_add_prize.clipsToBounds = true
        
        view_career_roadmap.layer.cornerRadius = 12
        view_career_roadmap.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        view_career_roadmap.layer.borderWidth = 1
        view_career_roadmap.clipsToBounds = true
        
        view_add_description.layer.cornerRadius = 12
        view_add_description.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        view_add_description.layer.borderWidth = 1
        view_add_description.clipsToBounds = true
        
        view_add_news.layer.cornerRadius = 12
        view_add_news.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        view_add_news.layer.borderWidth = 1
        view_add_news.clipsToBounds = true
        
        view_add_history.layer.cornerRadius = 12
        view_add_history.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        view_add_history.layer.borderWidth = 1
        view_add_history.clipsToBounds = true
        
        if AppData.user.type < Constants.TEAM_CLUB {
            view_others.isHidden = true
            view_add_description.isHidden = false
            view_career_roadmap.isHidden = false
//            constraintHeight.constant = 420
        } else{
            view_others.isHidden = false
            view_add_description.isHidden = true
            view_career_roadmap.isHidden = true
//            constraintHeight.constant = 510
        }
        
        lb_news_title.text = getString(key: "add_more_news")
        lb_news_desc.text = getString(key: "add_more_news_description")
        lb_history_title.text = getString(key: "add_history")
        lb_history_desc.text = getString(key: "add_history_description")
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickUploadVideo(_ sender: Any) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickUploadVideo()
            }
        })
    }
    
    @IBAction func onClickAddPrize(_ sender: Any) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickAddPrize()
            }
        })
    }
    
    @IBAction func onClickCareerRoadmap(_ sender: Any) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickCareerRoadmap()
            }
        })
    }
    
    @IBAction func onClickAddDescription(_ sender: Any) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickAddDescription()
            }
        })
    }
    
    @IBAction func onClickAddNews(_ sender: Any) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickAddNews()
            }
        })
    }
    
    @IBAction func onClickAddHistory(_ sender: Any) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickAddHistory()
            }
        })
    }
}

//
//  UploadYoutubeDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

protocol UploadYoutubeDialogDelegate {
    func onClickVideo()
    func onClickSubmit(title: String, video: YoutubeVideoInfo)
}

class UploadYoutubeDialog: UIViewController {
    
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var btn_upload: UIButton!
    @IBOutlet weak var btn_youtube: UIButton!
    @IBOutlet weak var view_title: UIView!
    @IBOutlet weak var text_title: UITextField!
    @IBOutlet weak var view_link: UIView!
    @IBOutlet weak var label_link: UILabel!
    @IBOutlet weak var btn_submit: UIButton!
    
    var delegate : UploadYoutubeDialogDelegate!
    var isUploadedVideo: Bool!
    var youtubeVideoInfo: YoutubeVideoInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true
        
        btn_upload.layer.cornerRadius = 4
        btn_upload.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        btn_upload.layer.borderWidth = 1
        btn_upload.clipsToBounds = true

        btn_youtube.layer.cornerRadius = 4
        btn_youtube.clipsToBounds = true
        
        view_title.layer.cornerRadius = 9
        view_title.clipsToBounds = true
        
        view_link.layer.cornerRadius = 9
        view_link.clipsToBounds = true
        
        btn_submit.layer.cornerRadius = 4
        btn_submit.clipsToBounds = true
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickUpload(_ sender: Any) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickVideo()
            }
        })
    }
    
    @IBAction func onClickYoutube(_ sender: Any) {
    }
    
    @IBAction func onClickLink(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "YoutubeSearchViewController") as! YoutubeSearchViewController
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        if (text_title.text?.isEmpty)! {
            self.showToast(message: "Please input title")
            return
        }
        if isUploadedVideo == false {
            self.showToast(message: "Please add link")
            return
        }
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickSubmit(title: self.text_title.text!, video: self.youtubeVideoInfo)
            }
        })
    }
}

extension UploadYoutubeDialog: YoutubeSearchViewControllerDelegate {
    func onFindLink(youtubeVideoInfo: YoutubeVideoInfo) {
        label_link.text = youtubeVideoInfo.id
        isUploadedVideo = true
        self.youtubeVideoInfo = youtubeVideoInfo
    }
}

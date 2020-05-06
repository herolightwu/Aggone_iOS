//
//  AddNewsDialog.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/28/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol AddNewsDialogDelegate {
    func onNewsDone()
}

class AddNewsDialog: UIViewController {
    
    @IBOutlet weak var lb_news: UILabel!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var txt_title: UITextField!
    @IBOutlet weak var lb_description: UILabel!
    @IBOutlet weak var txt_desc: UITextView!
    @IBOutlet weak var lb_available: UILabel!
    @IBOutlet weak var view_image: UIView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image0: UIImageView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint! //(610/550)
    
    var delegate: AddNewsDialogDelegate!
    
    var images:[UIImage] = []
    var datas:[Data] = []
    var img_views:[UIImageView] = []
    
    let picker = UIImagePickerController()
    var hud: JGProgressHUD!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"

        view_image.isHidden = true
        img_views.append(image0)
        img_views.append(image1)
        img_views.append(image2)
        
        lb_news.text = getString(key: "pf_news")
        lb_description.text = getString(key: "pf_description")
        lb_available.text = "0/3 " + getString(key: "dialog_attachment")
        constraintHeight.constant = 550
    }
    
    func refreshVC(){
        if images.count > 0 {
            constraintHeight.constant = 610
            view_image.isHidden = false
            var index = 0
            for img in images {
                img_views[index].image = img
                index += 1
            }
            lb_available.text = "\(images.count)/3 " + getString(key: "dialog_attachment")
        } else {
            constraintHeight.constant = 550
        }
    }

    @IBAction func onClickAddPhoto(_ sender: Any) {
        if images.count < 3 {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }

    @IBAction func onClickSubmit(_ sender: Any) {
        if (txt_title.text?.isEmpty)! {
            self.showToast(message: "Please input title")
            return
        }
        if (txt_desc.text?.isEmpty)! {
            self.showToast(message: "Please input description")
            return
        }
        if images.isEmpty {
            self.showToast(message: "Please choose images")
            return
        }
        
        let str_path = "article_\(AppData.user.id)_\(Int64(NSDate().timeIntervalSince1970))"
        hud.show(in: view)
        API.uploadArticles(name: str_path, images: datas, onSuccess: { response in
            
            let feed = Feed()
            feed.type = Constants.NEWS
            feed.user = AppData.user
            feed.title = self.txt_title.text!
            feed.video_url = ""
            feed.thumbnail_url = ""
            feed.sport = AppData.user.sport
            feed.like_count = 0
            feed.timestamp = Int64(NSDate().timeIntervalSince1970)
            feed.shared = 1
            feed.mode = Constants.FEED_PUBLIC
            feed.tagged = ""
            feed.articles = response
            feed.desc_str = self.txt_desc.text;
            API.saveFeed(feed: feed, onSuccess: {resp in
                self.hud.dismiss()
                self.actionBack(completion: {
                    if self.delegate != nil {
                        self.delegate.onNewsDone()
                    }
                })
            }, onFailed: { error in
                self.hud.dismiss()
                self.showToast(message: error)
            })
        }, onFailed: {err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
        
    }
}

extension AddNewsDialog: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let ind = images.count
        self.images.append( (info[UIImagePickerControllerOriginalImage] as? UIImage)!)
        dismiss(animated:true, completion: nil)
        
        self.datas.append(UIImagePNGRepresentation(self.images[ind])!)
        self.refreshVC()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

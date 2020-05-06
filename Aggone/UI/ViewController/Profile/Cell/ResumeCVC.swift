//
//  ResumeCVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 5/3/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

protocol ResumeCVCDelegate {
    func onDownload(ind: Int!)
}

class ResumeCVC: UICollectionViewCell {
    
    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var img_add: UIImageView!
    @IBOutlet weak var btn_download: UIButton!
    @IBOutlet weak var lb_name: UILabel!
    
    var user:User!
    var delegate : ResumeCVCDelegate!
    var index: Int!
    override func awakeFromNib() {
        
    }
    
    func setCell(data: Resume!){
        if data == nil {
            img_add.isHidden = false
        } else {
            if user.id == AppData.user.id{
                btn_download.setTitle("Delete", for: .normal)
            } else {
                btn_download.setTitle("Download", for: .normal)
            }
            img_add.isHidden = true
            if user.photo_url != "" {
                if user.photo_url.contains("http") {
                    img_avatar.sd_setImage(with: URL(string: user.photo_url), placeholderImage: nil)
                } else{
                    img_avatar.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + user.photo_url), placeholderImage: nil)
                }
            } else {
                img_avatar.image = UIImage(named: "default_avata")
            }
            lb_name.text = user.username
        }
        
    }
    
    @IBAction func onClickDownload(_ sender: Any) {
        if delegate != nil {
            delegate.onDownload(ind: index)
        }
    }
}

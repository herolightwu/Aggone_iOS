//
//  StoryViewUserCVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 5/2/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

class StoryViewUserCVC: UICollectionViewCell {
    
    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var img_msg: UIImageView!
    
    override func awakeFromNib() {
    }
    
    func setCell(stv: StoryView){
        if !stv.user.photo_url.isEmpty {
            if stv.user.photo_url.contains("http") {
                img_avatar.sd_setImage(with: URL(string: stv.user.photo_url), placeholderImage: nil)
            } else{
                img_avatar.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + stv.user.photo_url), placeholderImage: nil)
            }
        } else{
            img_avatar.image = UIImage(named: "default_avata")
        }
        if stv.reply_count > 0 {
            img_msg.isHidden = false
        } else{
            img_msg.isHidden = true
        }
    }
}

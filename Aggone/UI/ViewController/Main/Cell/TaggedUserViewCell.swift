//
//  TaggedUserViewCell.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/10/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

protocol TaggedUserViewCellDelegate {
    func onClickProfileBtn(index: Int)
}

class TaggedUserViewCell: UITableViewCell {

    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var lb_username: UILabel!
    @IBOutlet weak var lb_position: UILabel!
    
    var index: Int!
    var delegate: TaggedUserViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(user: User){
        if !user.photo_url.isEmpty {
            if user.photo_url.contains("http") {
                img_avatar.sd_setImage(with: URL(string: user.photo_url), placeholderImage: nil)
            } else{
                img_avatar.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + user.photo_url), placeholderImage: nil)
            }
        } else{
            img_avatar.image = UIImage(named: "default_avata")
        }
        lb_username.text = user.username
        lb_position.text = user.position
    }

    @IBAction func onClickAvatar(_ sender: Any) {
        if self.delegate != nil {
            delegate.onClickProfileBtn(index: self.index)
        }
    }
    @IBAction func onClickProfile(_ sender: Any) {
        if self.delegate != nil {
            delegate.onClickProfileBtn(index: self.index)
        }
    }
}

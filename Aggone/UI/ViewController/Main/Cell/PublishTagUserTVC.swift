//
//  PublishTagUserTVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/29/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

protocol PublishTagUserTVCDelegate {
    func onSelect(ind: Int)
}

class PublishTagUserTVC: UITableViewCell {

    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var lb_username: UILabel!
    @IBOutlet weak var lb_position: UILabel!
    @IBOutlet weak var btn_select: UIButton!
    @IBOutlet weak var view_sel: UIView!
    
    var index: Int!
    var delegate: PublishTagUserTVCDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view_sel.layer.borderWidth = 2
        view_sel.layer.masksToBounds = false
        view_sel.layer.borderColor = UIColor.from(hex: "#008598").cgColor
        view_sel.layer.cornerRadius = view_sel.frame.height/2
        view_sel.clipsToBounds = true
    }
    
    func setCell(user: User, bSel: Bool){
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
        
        if bSel {
            view_sel.backgroundColor = UIColor.from(hex: "#82BF3F")
        } else{
            view_sel.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func onClickSelect(_ sender: Any) {
        if delegate != nil {
            delegate.onSelect(ind: index)
        }
    }
    
}

//
//  SportSelectViewCell.swift
//  Aggone
//
//  Created by tiexiong on 3/19/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol SportSelectViewCellDelegate {
    func onTapSelect(index: Int)
    func onTapItem(st: Story)
}

class SportSelectViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var btn_select: UIButton!
    @IBOutlet weak var img_sport: CircleImageView!
    
    var delegate: SportSelectViewCellDelegate!
    var index : Int!
    var st : Story! = nil
    
    override func awakeFromNib() {
        img_avatar.layer.borderWidth = 1
        img_avatar.layer.masksToBounds = false
        img_avatar.layer.borderColor = primaryColor.cgColor
        img_avatar.layer.cornerRadius = img_avatar.frame.height/2
        img_avatar.layer.backgroundColor = bgColor.cgColor
        img_avatar.clipsToBounds = true
        
        btn_select.layer.borderWidth = 1
        btn_select.layer.masksToBounds = false
        btn_select.layer.borderColor = primaryColor.cgColor
        btn_select.layer.cornerRadius = btn_select.frame.height/2
        btn_select.layer.backgroundColor = bgColor.cgColor
        btn_select.clipsToBounds = true
        
    }
    
    func setCell(data: Sport) {
        img_sport.image = data.icon
        if data.selected {
            btn_select.layer.backgroundColor = primaryColor.cgColor
            btn_select.layer.borderColor = bgColor.cgColor
            btn_select.setTitleColor(bgColor, for: .normal)
            
        } else{
            btn_select.layer.backgroundColor = bgColor.cgColor
            btn_select.layer.borderColor = primaryColor.cgColor
            btn_select.setTitleColor(primaryColor, for: .normal)
        }
        btn_select.setTitle(data.name, for: .normal)
        
        img_avatar.isHidden = true
        if AppData.last_stories != nil && AppData.last_stories.count > 0 {
            guard let st = AppData.last_stories[data.id] else{
                self.st = nil
                return
            }
            self.st = st
            img_avatar.isHidden = false
            if st.user != nil && !st.user.photo_url.isEmpty {
                if st.user.photo_url.contains("http") {
                    img_avatar.sd_setImage(with: URL(string: st.user.photo_url), placeholderImage: nil)
                } else{
                    img_avatar.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + st.user.photo_url), placeholderImage: nil)
                }
            } else{
                img_avatar.image = UIImage(named: "profile")
            }
        }
        
    }
    @IBAction func onClickSelect(_ sender: Any) {
        if delegate != nil {
            delegate.onTapSelect(index: index)
        }
    }
    
    @IBAction func onClickItem(_ sender: Any) {
        if delegate != nil && st != nil{
            delegate.onTapItem(st: st)
        }
    }
    func getString(key: String)->String {
        return NSLocalizedString(key, comment: "")
    }
}

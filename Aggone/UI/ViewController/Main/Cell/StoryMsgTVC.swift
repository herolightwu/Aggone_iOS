//
//  StoryMsgTVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 5/2/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

class StoryMsgTVC: UITableViewCell {

    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var lb_msg: UILabel!
    @IBOutlet weak var lb_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(sm:StoryMsg){
        if !sm.user.photo_url.isEmpty {
            if sm.user.photo_url.contains("http") {
                img_avatar.sd_setImage(with: URL(string: sm.user.photo_url), placeholderImage: nil)
            } else{
                img_avatar.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + sm.user.photo_url), placeholderImage: nil)
            }
        } else{
            img_avatar.image = UIImage(named: "default_avata")
        }
        
        if sm.reply_type == Constants.REPLY_TYPE_TEXT {
            lb_msg.text = sm.content
        }
        
        let diff = Int64(Date().timeIntervalSince1970) - sm.timestamp
        lb_time.text = "reply: " + getRestTime(diff: diff)
    }
    
    func getRestTime(diff: Int64)->String!{
        var rest_time = "";
        if (diff < 60){
            rest_time = String(diff) + "seconds ago ";
        } else if(diff < 3600){
            rest_time = String(Int(diff/60)) + "mins ago";
        } else{
            rest_time = String(Int(diff/3600)) + "hours ago";
        }
        return rest_time;
    }

}

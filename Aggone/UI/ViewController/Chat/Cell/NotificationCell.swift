//
//  NotificationCell.swift
//  Aggone
//
//  Created by APPLE on 2019/4/12.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var image_avata: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_message: UILabel!
    @IBOutlet weak var label_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image_avata.layer.cornerRadius = image_avata.frame.size.height / 2
        image_avata.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(notification:Notification) {
        if notification.user.photo_url.isEmpty {
            image_avata.image = UIImage(named: "default_avata")
        } else {
            if notification.user.photo_url.contains("http") {
                image_avata.sd_setImage(with: URL(string: notification.user.photo_url), placeholderImage: nil)
            } else{
                image_avata.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + notification.user.photo_url), placeholderImage: nil)
            }
        }
        label_name.text = notification.user.username
        if notification.type == "like" {
            label_message.text = getString(key: "notification_like")
        } else if notification.type == "follow" {
            label_message.text = getString(key: "notification_follow")
        } else if notification.type == "chat" {
            label_message.text = getString(key: "notification_chat")
        } else{
            label_message.text = notification.content_msg
        }
        
        if Utils.deltaTimeString(delta: Int64(Date().timeIntervalSince1970) - notification.timestamp).isEmpty {
            let date = Date(timeIntervalSince1970: TimeInterval(notification.timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            label_time.text = dateFormatter.string(from: date)
        } else {
            label_time.text = "\(Utils.deltaTimeString(delta: Int64(Date().timeIntervalSince1970) - notification.timestamp))"
        }
    }
}

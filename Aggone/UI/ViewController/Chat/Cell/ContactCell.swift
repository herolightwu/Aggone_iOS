//
//  ContactCell.swift
//  Aggone
//
//  Created by APPLE on 2019/4/5.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import SwipeCellKit

class ContactCell: SwipeTableViewCell {

    @IBOutlet weak var image_avata: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_message: UILabel!
    @IBOutlet weak var label_time: UILabel!
    @IBOutlet weak var image_unread: UIImageView!
    @IBOutlet weak var label_unread_count: UILabel!
    
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image_avata.layer.cornerRadius = image_avata.frame.size.height / 2
        image_avata.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(contact: Contact) {
        if contact.user.photo_url.isEmpty {
            image_avata.image = UIImage(named: "default_avata")
        } else {
            if contact.user.photo_url.contains("http") {
                image_avata.sd_setImage(with: URL(string: contact.user.photo_url), placeholderImage: nil)
            } else{
                image_avata.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + contact.user.photo_url), placeholderImage: nil)
            }
        }
        label_name.text = contact.user.username
        label_message.text = contact.message
        if Utils.deltaTimeString(delta: Int64(Date().timeIntervalSince1970) - contact.timestamp).isEmpty {
            let date = Date(timeIntervalSince1970: TimeInterval(contact.timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            label_time.text = dateFormatter.string(from: date)
        } else {
            label_time.text = "\(Utils.deltaTimeString(delta: Int64(Date().timeIntervalSince1970) - contact.timestamp))"
        }
        if contact.unread_count > 0 {
            image_unread.isHidden = false
            label_unread_count.isHidden = false
            label_unread_count.text = "\(contact.unread_count)"
        } else {
            image_unread.isHidden = true
            label_unread_count.isHidden = true
        }
    }
}

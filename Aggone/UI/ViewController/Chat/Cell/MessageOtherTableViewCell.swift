//
//  MessageOtherTableViewCell.swift
//  Aggone
//
//  Created by tiexiong on 5/25/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

class MessageOtherTableViewCell: UITableViewCell {

    @IBOutlet var image_avata: UIImageView!
    @IBOutlet var label_message: UILabel!
    @IBOutlet weak var label_time: UILabel!
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var label_name: UILabel!
    
    var user: User!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image_avata.layer.cornerRadius = image_avata.frame.height / 2
        image_avata.clipsToBounds = true
        
//        let path = UIBezierPath(roundedRect: view_panel.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
//        let mask = CAShapeLayer()
//        mask.path = path
//        view_panel.layer.mask = mask
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(chat: Chat) {
        if user.photo_url.isEmpty {
            image_avata.image = UIImage(named: "default_avata")
        } else {
            if user.photo_url.contains("http") {
                image_avata.sd_setImage(with: URL(string: user.photo_url), placeholderImage: nil)
            } else{
                image_avata.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + user.photo_url), placeholderImage: nil)
            }
        }
        label_name.text = user.username
        label_message.text = chat.message
        if Utils.deltaTimeString(delta: Int64(Date().timeIntervalSince1970) - chat.timestamp).isEmpty {
            let date = Date(timeIntervalSince1970: TimeInterval(chat.timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            label_time.text = dateFormatter.string(from: date)
        } else {
            label_time.text = "\(Utils.deltaTimeString(delta: Int64(Date().timeIntervalSince1970) - chat.timestamp))"
        }
    }
}

//
//  BlockedUserCell.swift
//  Aggone
//
//  Created by tiexiong on 5/25/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

protocol BlockedUserCellDelegate {
    func onClickBlock(index: Int)
}

class BlockedUserCell: UITableViewCell {

    @IBOutlet weak var image_photo: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_position: UILabel!
    @IBOutlet weak var label_club: UILabel!
    @IBOutlet weak var btn_block: UIButton!
    
    var index: Int!
    var delegate: BlockedUserCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        image_photo.layer.cornerRadius = image_photo.frame.height / 2
        image_photo.clipsToBounds = true
        
        btn_block.layer.cornerRadius = 4
        btn_block.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(user: User) {
        if user.photo_url != "" {
            if user.photo_url.contains("http") {
                image_photo.sd_setImage(with: URL(string: user.photo_url), placeholderImage: nil)
            } else{
                image_photo.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + user.photo_url), placeholderImage: nil)
            }
        } else {
            image_photo.image = UIImage(named: "default_avata")
        }
        label_name.text = user.username
        label_position.text = user.position
        label_club.text = user.club
    }
    
    @IBAction func onClickBlock(_ sender: Any) {
        if delegate != nil {
            delegate.onClickBlock(index: index)
        }
    }
}

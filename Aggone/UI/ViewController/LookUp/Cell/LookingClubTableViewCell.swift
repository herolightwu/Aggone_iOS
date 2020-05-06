//
//  LookingClubTableViewCell.swift
//  Aggone
//
//  Created by tiexiong on 5/24/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

protocol LookingClubCellDelegates {
}

class LookingClubTableViewCell: UITableViewCell {

    @IBOutlet var image_photo: UIImageView!
    @IBOutlet var btn_sport: UIButton!
    @IBOutlet var btn_position: UIButton!
    @IBOutlet var label_description: UILabel!
    @IBOutlet var label_name: UILabel!
    @IBOutlet weak var btn_follow: UIButton!
    
    var index: Int!
    var delegate: LookingClubCellDelegates!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image_photo.layer.cornerRadius = image_photo.frame.height / 2
        image_photo.clipsToBounds = true
        
        btn_sport.layer.cornerRadius = 10
        btn_sport.layer.borderWidth = 1
        btn_sport.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        btn_sport.clipsToBounds = true
        
        btn_position.layer.cornerRadius = 10
        btn_position.layer.borderWidth = 1
        btn_position.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        btn_position.clipsToBounds = true
        
        btn_follow.setTitle(getString(key:"follow"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(admob: Admob) {
        if admob.user.photo_url != "" {
            if admob.user.photo_url.contains("http") {
                image_photo.sd_setImage(with: URL(string: admob.user.photo_url), placeholderImage: nil)
            } else{
                image_photo.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + admob.user.photo_url), placeholderImage: nil)
            }
        } else {
            image_photo.image = UIImage(named: "default_avata")
        }
        label_name.text = admob.user.username
        btn_sport.setTitle(UIViewController.getSportName(sport: admob.sport), for: .normal)
        btn_position.setTitle(admob.position, for: .normal)
        label_description.text = admob.description
    }
}

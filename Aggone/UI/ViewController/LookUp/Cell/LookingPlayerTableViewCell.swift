//
//  LookingPlayerTableViewCell.swift
//  Aggone
//
//  Created by tiexiong on 5/24/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

protocol LookingPlayerCellDelegate {
}

class LookingPlayerTableViewCell: UITableViewCell {

    @IBOutlet var image_photo: UIImageView!
    @IBOutlet var label_name: UILabel!
    @IBOutlet var btn_position: UIButton!
    @IBOutlet var btn_sport: UIButton!
    @IBOutlet weak var btn_follow: UIButton!
    @IBOutlet weak var btn_club: UIButton!
    
    @IBOutlet weak var label_name1: UILabel!
    @IBOutlet weak var label_name2: UILabel!
    @IBOutlet weak var label_name3: UILabel!
    @IBOutlet weak var label_name4: UILabel!
    @IBOutlet weak var label_name5: UILabel!
    @IBOutlet weak var label_name6: UILabel!
    
    @IBOutlet weak var label_value1: UILabel!
    @IBOutlet weak var label_value2: UILabel!
    @IBOutlet weak var label_value3: UILabel!
    @IBOutlet weak var label_value4: UILabel!
    @IBOutlet weak var label_value5: UILabel!
    @IBOutlet weak var label_value6: UILabel!
    
    
    var index: Int!
    var delegate: LookingPlayerCellDelegate!
    
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
        
        btn_club.layer.cornerRadius = 10
        btn_club.layer.borderWidth = 1
        btn_club.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        btn_club.clipsToBounds = true
        
        btn_follow.setTitle(getString(key:"follow"), for: .normal)
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
        btn_sport.setTitle(UIViewController.getSportName(sport: user.sport), for: .normal)
        btn_position.setTitle(getTypeName(type: user.type), for: .normal)
        btn_club.setTitle(user.contract, for: .normal)
        
        label_value1.text = user.club
        label_value2.text = user.category
        label_value3.text = user.position
        
        API.getSportResultSummary(user: user, onSuccess: { response in
            let skills = UIViewController.getSportSkills(sport: user.sport, apiResult: response)
            self.label_value4.text = "\(skills[0].value)"
            self.label_value5.text = "\(skills[1].value)"
            self.label_value6.text = "\(skills[2].value)"
            
            self.label_name4.text = skills[0].description
            self.label_name5.text = skills[1].description
            self.label_name6.text = skills[2].description
        }, onFailed: { error in
        })
    }
    
}

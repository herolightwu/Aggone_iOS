//
//  FilterResultCollectionViewCell.swift
//  Aggone
//
//  Created by tiexiong on 5/23/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import SDWebImage

class FilterResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var image_photo: UIImageView!
    @IBOutlet var label_name: UILabel!
    @IBOutlet var label_firstname: UILabel!
    
    func setCell(user:User) {
        image_photo.layer.cornerRadius = image_photo.frame.height / 2
        image_photo.clipsToBounds = true
        if user.photo_url != "" {
            image_photo.sd_setImage(with: URL(string: user.photo_url), placeholderImage: nil)
        } else {
            image_photo.image = #imageLiteral(resourceName: "profile")
        }
    }
}

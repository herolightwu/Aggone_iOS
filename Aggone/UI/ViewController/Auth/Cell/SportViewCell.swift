//
//  SportViewCell.swift
//  Aggone
//
//  Created by tiexiong on 2/24/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

class SportViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_detail: UILabel!
    @IBOutlet weak var img_icon: UIImageView!
    
    var index : Int!
    
    func setCell(data: Sport, prefex: String) {
        label_name.text = data.name
        label_detail.text = prefex + data.name
        img_icon.image = data.icon
    }
}

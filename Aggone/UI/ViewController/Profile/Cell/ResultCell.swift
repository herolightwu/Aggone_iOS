//
//  ResultCell.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

class ResultCell: UICollectionViewCell {
    
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_value: UILabel!
    
    var index : Int!
    
    func setCell(skill: Skill) {
        label_type.text = skill.summary
        label_value.text = "\(skill.value)"
    }
}

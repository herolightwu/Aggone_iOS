//
//  SkillCell.swift
//  Aggone
//
//  Created by APPLE on 2019/4/2.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol SkillCellDelegate {
    func onClickMinus(index: Int)
    func onClickPlus(index: Int)
}

class SkillCell: UITableViewCell {

    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_value: UILabel!
    
    var index: Int!
    var delegate: SkillCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(parent: UIViewController,  type: Int!, description: Description) {
        label_name.text = parent.getDescriptionName(type: type, id: description.type)
        label_value.text = "\(description.value)"
    }
    
    @IBAction func onClickMinus(_ sender: Any) {
        if delegate != nil {
            delegate.onClickMinus(index: index)
        }
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        if delegate != nil {
            delegate.onClickPlus(index: index)
        }
    }
}

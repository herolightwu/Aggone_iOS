//
//  StatsCell.swift
//  Aggone
//
//  Created by APPLE on 2019/4/11.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol StatsCellDelegate {
    func onClickMinus(index: Int)
    func onClickPlus(index: Int)
    func onClickFloat(index: Int)
}

class StatsCell: UITableViewCell {

    @IBOutlet weak var label_skill: UILabel!
    @IBOutlet weak var label_value: UILabel!
    @IBOutlet weak var label_float_value: UILabel!
    @IBOutlet weak var view_integer: UIView!
    @IBOutlet weak var view_float: UIView!
    
    var index: Int!
    var delegate: StatsCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(skill: Skill) {
        label_skill.text = skill.description
        if skill.key == Constants.PERFORMANCE {
            view_integer.isHidden = true
            view_float.isHidden = false
            label_float_value.text = "\(String(format: "%.1f", Float(skill.value) / 10))"
        } else {
            view_integer.isHidden = false
            view_float.isHidden = true
            label_value.text = "\(skill.value)"
        }
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
    
    @IBAction func onClickFloat(_ sender: Any) {
        if delegate != nil {
            delegate.onClickFloat(index: index)
        }
    }
}

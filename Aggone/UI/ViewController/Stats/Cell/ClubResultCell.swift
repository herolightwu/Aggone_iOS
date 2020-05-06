//
//  ClubResultCell.swift
//  Aggone
//
//  Created by APPLE on 2019/4/9.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol ClubResultCellDelegate {
    func onClickPlus(club: String!, section: Int!, index: Int)
    func onClickMinus(club: String!, section: Int!, index: Int)
    func onClickFloat(club: String!, section: Int!, index: Int)
}

class ClubResultCell: UITableViewCell {

    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_value: UILabel!
    @IBOutlet weak var view_edit: UIView!
    @IBOutlet weak var lb_value: UILabel!
    @IBOutlet weak var view_float: UIView!
    @IBOutlet weak var lb_float: UILabel!
    
    var index: Int!
    var section: Int!
    var delegate: ClubResultCellDelegate!
    
    var clubname: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_edit.isHidden = true
        view_float.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickMinus(_ sender: Any) {
        if delegate != nil {
            delegate.onClickMinus(club: clubname, section:section, index: index)
        }
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        if delegate != nil {
            delegate.onClickPlus(club: clubname, section:section, index: index)
        }
    }
    
    @IBAction func onClickFloat(_ sender: Any) {
        if delegate != nil {
            delegate.onClickFloat(club: clubname, section:section, index: index)
        }
    }
    
    func setCell(skill: Skill, bEdit: Bool!){
        if bEdit {
            view_edit.isHidden = false
            if skill.key == Constants.PERFORMANCE {
                view_edit.isHidden = true
                view_float.isHidden = false
                lb_float.text = "\(String(format: "%.1f", Float(skill.value) / 10))"
            } else {
                view_edit.isHidden = false
                view_float.isHidden = true
                lb_value.text = "\(skill.value)"
            }
        } else{
            view_edit.isHidden = true
            view_float.isHidden = true
        }
        
        label_name.text = skill.description
        
        if skill.key == Constants.PERFORMANCE {
            label_value.text = "\(String(format: "%.1f", Float(skill.value) / 10))"
        } else {
            label_value.text = "\(skill.value)"
        }
    }
    
}

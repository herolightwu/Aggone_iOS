//
//  ClubResultHeaderCell.swift
//  Aggone
//
//  Created by APPLE on 2019/4/9.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import DropDown

protocol ClubResultHeaderCellDelegate {
    func onClickEdit(sect: Int!)
    func onClickDelete(club: String!)
    func onChangeYear(sect: Int!, year:Int!)
    func onChangeMonth(sect: Int!, month:Int!)
}

class ClubResultHeaderCell: UITableViewCell {
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var view_title: UIView!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var btn_month: UIButton!
    @IBOutlet weak var btn_year: UIButton!
    
    var sect_ind: Int!
    var delegate: ClubResultHeaderCellDelegate!
    var year_months:[(String, [String])] = []
    var month_ind: Int! = 0
    var year_ind: Int! = 0
    
    let month_list: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    var dd_month: DropDown!
    var dd_year: DropDown!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_title.layer.borderWidth = 1
        view_title.layer.masksToBounds = false
        view_title.layer.borderColor = primaryColor.cgColor
        view_title.layer.cornerRadius = 7
        view_title.clipsToBounds = true
        
        btn_delete.isHidden = true
        btn_month.isHidden = true
        btn_year.isHidden = true
        
        btn_month.setTitle("", for: .normal)
        btn_year.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickDelete(_ sender: Any) {
        if delegate != nil {
            delegate.onClickDelete(club: label_title.text)
        }
    }
    
    @IBAction func onClickEdit(_ sender: Any) {
        if delegate != nil {
            delegate.onClickEdit(sect: sect_ind)
        }
    }
    
    @IBAction func onClickMonth(_ sender: Any) {
        var months: [String] = []
        for one in year_months[year_ind].1 {
            months.append(one)
        }
        dd_month = DropDown()
        dd_month.anchorView = btn_month
        dd_month.direction = .any
        dd_month.localizationKeysDataSource = month_list //months
        dd_month.selectionAction = { [unowned self] (index: Int, item: String) in
            self.month_ind = index
            self.btn_month.setTitle(item, for: .normal)
            if self.delegate != nil {
                self.delegate.onChangeMonth(sect: self.sect_ind, month: index)
            }
        }
        dd_month.show()
    }
    
    @IBAction func onClickYear(_ sender: Any) {
        var years: [String] = []
        for one in year_months {
            years.append(one.0)
        }
        dd_year = DropDown()
        dd_year.anchorView = btn_year
        dd_year.direction = .any
        dd_year.localizationKeysDataSource = years
        dd_year.selectionAction = { [unowned self] (index: Int, item: String) in
            self.year_ind = index
            self.btn_year.setTitle(item, for: .normal)
            if self.delegate != nil {
                self.delegate.onChangeYear(sect: self.sect_ind, year: index)
            }
        }
        dd_year.show()
    }
    
    func setHeaderCell(catelist: [(String, [String])], selected: (Int, Int), bEdit: Bool!){
        if bEdit {
            btn_delete.isHidden = false
            btn_year.isHidden = false
            btn_month.isHidden = false
            btn_edit.setImage(UIImage(named: "check"), for: .normal)
        } else{
            btn_delete.isHidden = true
            btn_month.isHidden = true
            btn_year.isHidden = true
            btn_edit.setImage(UIImage(named: "ic_edit_pen"), for: .normal)
        }
        year_ind = selected.0
        month_ind = selected.1
        year_months = catelist
        btn_year.setTitle(catelist[year_ind].0, for: .normal)
        //btn_month.setTitle(catelist[year_ind].1[month_ind], for: .normal)
        btn_month.setTitle(month_list[month_ind], for: .normal)
    }
    
}

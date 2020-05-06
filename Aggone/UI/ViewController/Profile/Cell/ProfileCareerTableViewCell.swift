//
//  ProfileCareerTableViewCell.swift
//  Aggone
//
//  Created by tiexiong on 5/29/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import SwipeCellKit

class ProfileCareerTableViewCell: SwipeTableViewCell {
    @IBOutlet var label_position: UILabel!
    @IBOutlet var label_location: UILabel!
    @IBOutlet var label_sport: UILabel!
    @IBOutlet var label_date: UILabel!
    @IBOutlet weak var image_logo: UIImageView!
    
    var index:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(career: Career) {
        if !career.logo.isEmpty {
            if career.logo.contains("http") {
                image_logo.sd_setImage(with: URL(string: career.logo), placeholderImage: nil)
            } else{
                image_logo.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + career.logo), placeholderImage: nil)
            }
        }
        label_location.text = career.club + " - " + career.location
        label_position.text = career.position
        label_sport.text = career.sport
        let fromDate = Date.from(year: career.year, month: career.month, day: career.day)
        var toDate = Date()
        if career.tyear > 0 {
            toDate = Date.from(year: career.tyear, month: career.tmonth, day: career.tday)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        label_date.text = dateFormatter.string(from: fromDate) + " - " + (career.tyear > 0 ? dateFormatter.string(from: toDate) : "")
    }
}

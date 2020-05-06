//
//  MessageMineTableViewCell.swift
//  Aggone
//
//  Created by tiexiong on 5/25/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import SwipeCellKit

class MessageMineTableViewCell: SwipeTableViewCell {
    @IBOutlet var label_message: UILabel!
    @IBOutlet weak var label_time: UILabel!
    @IBOutlet weak var view_panel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(chat: Chat) {
        label_message.text = chat.message
        if Utils.deltaTimeString(delta: Int64(Date().timeIntervalSince1970) - chat.timestamp).isEmpty {
            let date = Date(timeIntervalSince1970: TimeInterval(chat.timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            label_time.text = dateFormatter.string(from: date)
        } else {
            label_time.text = "\(Utils.deltaTimeString(delta: Int64(Date().timeIntervalSince1970) - chat.timestamp))"
        }
    }
}

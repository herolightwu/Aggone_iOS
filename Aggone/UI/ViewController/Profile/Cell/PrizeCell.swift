//
//  PrizeCell.swift
//  Aggone
//
//  Created by tiexiong on 3/21/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

protocol PrizeCellDelegate {
    func onLongClick(index: Int)
}

class PrizeCell: UICollectionViewCell {
    
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var image_icon: UIImageView!
    
    var index : Int!
    var delegate: PrizeCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPress(_ longPressRecognizer: UILongPressGestureRecognizer) {
        if delegate != nil {
            if longPressRecognizer.state == .began {
                self.delegate.onLongClick(index: self.index)
            }
        }
    }
    
    func setCell(prize: Prize) {
        label_title.text = prize.title
        label_description.text = prize.club + " " + prize.year
        image_icon.image = getIconImage(icon: prize.icon)
    }
    
    func getIconImage(icon: Int)->UIImage {
        switch icon {
        case 0:
            return UIImage.init(named: "icon_prize1")!
        case 1:
            return UIImage.init(named: "icon_prize2")!
        case 2:
            return UIImage.init(named: "icon_prize3")!
        case 3:
            return UIImage.init(named: "icon_prize4")!
        case 4:
            return UIImage.init(named: "icon_prize5")!
        default:
            return UIImage.init(named: "icon_prize1")!
        }
    }
}

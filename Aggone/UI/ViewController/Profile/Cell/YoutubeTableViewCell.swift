//
//  YoutubeTableViewCell.swift
//  Aggone
//
//  Created by tiexiong on 5/31/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

class YoutubeTableViewCell: UITableViewCell {

    @IBOutlet var image_thumbnail: UIImageView!
    @IBOutlet var label_title: UILabel!
    @IBOutlet var label_description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(video: YoutubeVideoInfo) {
        if video.thumbnailUrl != "" {
            self.image_thumbnail.sd_setImage(with: URL(string: video.thumbnailUrl), placeholderImage: nil)
        }
        label_title.text = video.title
        label_description.text = video.description
    }
}

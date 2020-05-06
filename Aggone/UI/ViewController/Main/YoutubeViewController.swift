//
//  YoutubeViewController.swift
//  Aggone
//
//  Created by APPLE on 2019/4/5.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import YouTubePlayer

class YoutubeViewController: UIViewController {
    
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var view_menu: UIView!
    @IBOutlet weak var youtube_view: YouTubePlayerView!
    
    var video_url: String!
    var video_title: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        lockOrientation([.landscapeLeft, .landscapeRight], andRotateTo: .landscapeRight)
        lockOrientation(.all, andRotateTo: .portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    func setViewController() {
        label_title.text = video_title
        youtube_view.loadVideoID(video_url)
    }
    
    @IBAction func onClickShare(_ sender: Any) {
    }
    
    @IBAction func onClickDownload(_ sender: Any) {
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
}

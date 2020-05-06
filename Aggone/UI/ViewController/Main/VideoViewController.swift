//
//  VideoViewController.swift
//  Aggone
//
//  Created by APPLE on 2019/4/5.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {

    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var view_video: UIView!
    @IBOutlet weak var view_menu: UIView!
    
    var playerController: AVPlayerViewController!
    
    var video_url: String!
    var video_title: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.all, andRotateTo: .portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    func setViewController() {
        label_title.text = video_title
        
        if !video_url.contains("http") {
            video_url = API.baseUrl + API.videoDirUrl + video_url;
        }
        
        for subview in view_video.subviews {
            subview.removeFromSuperview()
        }
        let videoURL = URL(string: video_url)
        let player = AVPlayer(url: videoURL! as URL)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.view.frame = view_video.bounds
        view_video.addSubview(playerController.view)
//        playerController.contentOverlayView?.addSubview(view_menu)
    }
    
    @IBAction func onClickShare(_ sender: Any) {
    }
    
    @IBAction func onClickDownload(_ sender: Any) {
    }    
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
}

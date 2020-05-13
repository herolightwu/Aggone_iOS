//
//  UploadVideoDialog.swift
//  Aggone
//
//  Created by tiexiong on 3/20/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

protocol UploadVideoDialogDelegate {
    func onClickYoutube()
    func onClickStory(title: String)
    func onClickSubmit(title: String, video:URL!)
}

class UploadVideoDialog: UIViewController {
    
    @IBOutlet weak var view_panel: UIView!
    @IBOutlet weak var btn_upload: UIButton!
    @IBOutlet weak var btn_youtube: UIButton!
    @IBOutlet weak var view_title: UIView!
    @IBOutlet weak var text_title: UITextField!
    @IBOutlet weak var btn_submit: UIButton!
    @IBOutlet weak var lb_video: UILabel!
    @IBOutlet weak var lb_stories: UILabel!
    
    var delegate : UploadVideoDialogDelegate!
    var isUploadedVideo : Bool!
    
    var video_url: URL!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self

        view_panel.layer.cornerRadius = 12
        view_panel.clipsToBounds = true
        
        btn_upload.layer.cornerRadius = 4
        btn_upload.clipsToBounds = true

        btn_youtube.layer.cornerRadius = 4
        btn_youtube.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        btn_youtube.layer.borderWidth = 1
        btn_youtube.clipsToBounds = true
        
        view_title.layer.cornerRadius = 9
        view_title.clipsToBounds = true
        
        btn_submit.layer.cornerRadius = 4
        btn_submit.clipsToBounds = true
        
        lb_video.text = getString(key: "pf_videos")
        lb_stories.text = getString(key: "pf_story")
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickUpload(_ sender: Any) {
    }
    
    @IBAction func onClickYoutube(_ sender: Any) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickYoutube()
            }
        })
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Add Video", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .camera
            self.picker.mediaTypes = [kUTTypeMovie as String]
            self.present(self.picker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = [kUTTypeMovie as String]
            self.present(self.picker, animated: true, completion: nil)
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickStories(_ sender: Any) {
//        if (text_title.text?.isEmpty)! {
//            self.showToast(message: "Please input title")
//            return
//        }
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickStory(title: self.text_title.text!)
            }
        })
        
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        if (text_title.text?.isEmpty)! {
            self.showToast(message: "Please input title")
            return
        }
        if isUploadedVideo == false {
            self.showToast(message: "Please add video")
            return
        }
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onClickSubmit(title: self.text_title.text!, video: self.video_url)
            }
        })
    }
    
    func compressVideo(inputURL: URL,
                       outputURL: URL,
                       handler:@escaping (_ exportSession: AVAssetExportSession?) -> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset,
                                                       presetName: AVAssetExportPreset1280x720) else {
            handler(nil)

            return
        }

        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        exportSession.exportAsynchronously {
            handler(exportSession)
        }
    }
}


extension UploadVideoDialog: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let videoURL = info[UIImagePickerControllerMediaURL] as? URL
        isUploadedVideo = true
        let data = NSData(contentsOf: videoURL! as URL)!
         print("File size before compression: \(Double(data.length / 1024)) kb") /// 1048576
         video_url = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".mp4")
        compressVideo(inputURL: videoURL!, outputURL: video_url) { (exportSession) in
                 guard let session = exportSession else {
                     return
                 }

                 switch session.status {
                 case .unknown:
                     break
                 case .waiting:
                     break
                 case .exporting:
                     break
                 case .completed:
                    guard let compressedData = NSData(contentsOf: self.video_url) else {
                         return
                     }
                    print("File size after compression: \(Double(compressedData.length / 1024)) kb") /// 1048576
                 case .failed:
                     break
                 case .cancelled:
                     break
                 }
             }
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

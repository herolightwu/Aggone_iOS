//
//  MainViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/22/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import JHTAlertController
import AVKit
import MobileCoreServices
import JGProgressHUD
import FirebaseDatabase
import iOSPhotoEditor

class MainViewController: UIViewController {
    
    @IBOutlet var table_view: UITableView!
    @IBOutlet weak var tagged_table: UITableView!
    @IBOutlet weak var btn_profile: UIButton!
    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var label_filter: UILabel!
    
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var view_tab: UIView!
    @IBOutlet weak var view_filter: UIView!
    
    @IBOutlet weak var btn_world: UIButton!
    @IBOutlet weak var btn_my: UIButton!    
    
    @IBOutlet weak var const_tab_bottom: NSLayoutConstraint!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var view_tagged: UIView!
    @IBOutlet weak var view_tag_users: UIView!
    @IBOutlet weak var lb_tagged_users: UILabel!
    @IBOutlet weak var const_tag_height: NSLayoutConstraint!
    @IBOutlet weak var const_tag_bottom: NSLayoutConstraint!
    
    let refreshControl = UIRefreshControl()
    var page: Int = 1
    var feedMode: Int = Constants.WORLD
    var height_tag_view : Float = 350.0
    var report_sel : Int = -1
    var feeds:[Feed] = []
    
    var sports:[Sport] = []
    
    var tag_users:[User] = []
    
    var hud: JGProgressHUD!
    
    let picker = UIImagePickerController()
    var storyphoto: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        view_filter.isHidden = true
        btn_world.layer.cornerRadius = 10
        btn_my.layer.cornerRadius = 10
        btn_my.layer.borderWidth = 2
        btn_my.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        
        img_avatar.layer.cornerRadius = 15
        img_avatar.layer.borderWidth = 1
        img_avatar.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor

        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        table_view.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection_view.setCollectionViewLayout(layout, animated: true)
        sports = getAllSports()
//        collection_view.reloadData()
        view_tagged.isHidden = true
        
        lb_tagged_users.text = getString(key: "txt_tagged_users")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        if AppData.user == nil || AppData.user.id.count == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AuthNavigationController") as! UINavigationController
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(controller, animated: true, completion: nil)
            return
        }
        reloadData()
    }
    
    func reloadData() {
        if !AppData.user.photo_url.isEmpty {
            if AppData.user.photo_url.contains("http") {
                img_avatar.sd_setImage(with: URL(string:AppData.user.photo_url), placeholderImage: nil)
            } else{
                img_avatar.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + AppData.user.photo_url), placeholderImage: nil)
            }
        }
        let sortedSport = sports.sorted(by : {
            (one: Sport, two: Sport) -> Bool in
            var m1 = one.selected ? 3000 : 0
            var m2 = two.selected ? 3000: 0
            if one.id == AppData.user.sport {
                m1 += 2000
            }
            if two.id == AppData.user.sport {
                m2 += 2000
            }
            let diff = (m2 - two.id) - (m1 - one.id)
            return diff < 0
        })
        sports = sortedSport
        collection_view.reloadData()
        API.getAllStory(onSuccess: { result in
            self.collection_view.reloadData()
        }, onFailed: { err in
            
        })
    }

    @objc func refresh() {
        var selectedSports: String = ""
        for sport in sports {
            if sport.selected {
                if !selectedSports.isEmpty {
                    selectedSports = selectedSports + ","
                }
                selectedSports = selectedSports + "\(sport.id ?? 0)"
            }
        }
        page = 1
        if feedMode == Constants.WORLD {
            API.getSportsFeed(page: page, sport: selectedSports, user_id: AppData.user.id, onSuccess: { feeds in
                self.feeds.removeAll()
                self.feeds = feeds
                self.table_view.reloadData()
                self.refreshControl.endRefreshing()
            }, onFailed: { error in
                self.showToast(message: error)
                self.refreshControl.endRefreshing()
            })
        } else {
            API.getMyFeeds(page: page, sport: selectedSports, onSuccess: { feeds in
                self.feeds.removeAll()
                self.feeds = feeds
                self.table_view.reloadData()
                self.refreshControl.endRefreshing()
            }, onFailed: { error in
                self.showToast(message: error)
                self.refreshControl.endRefreshing()
            })
        }
        
        API.getAllStory(onSuccess: { result in
            self.collection_view.reloadData()
        }, onFailed: { err in
            
        })
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = AppData.user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickCamera(_ sender: Any) {
        let controller = UploadVideoDialog.init(nibName: "UploadVideoDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.isUploadedVideo = false
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickFilter(_ sender: Any) {
        view_filter.isHidden = false
    }
    
    @IBAction func onClickWorld(_ sender: Any) {
        view_filter.isHidden = true
        feedMode = Constants.WORLD
        label_filter.text = getString(key: "world")
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    @IBAction func onClickMy(_ sender: Any) {
        view_filter.isHidden = true
        feedMode = Constants.MY
        label_filter.text = getString(key: "my")
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    @IBAction func onClickDownFilter(_ sender: Any) {
        view_filter.isHidden = true
    }
    
    var duringAnimation: Bool = false
    func hideTab(hidden: Bool) {
        if duringAnimation { return }
        
        let duration:TimeInterval = 0.3
        duringAnimation = true
        
        self.const_tab_bottom.constant = hidden ? -90 : 0
        UIView.animate(withDuration: duration, animations: { () in
            self.view_tab.layoutIfNeeded()
        }, completion: { result in
            self.duringAnimation = false
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.table_view.panGestureRecognizer.translation(in: table_view).y < 0 {
            hideTab(hidden: true)
        } else {
            hideTab(hidden: false)
        }
    }
    
    func showTaggedView(tagged: String){
        
        API.getTaggedUsers(tagged: tagged, onSuccess: {response in
            self.tag_users = response
            self.height_tag_view = Float(response.count + 1) * 60.0 + 12.0
            if self.height_tag_view > 360 {
                self.height_tag_view = 360
            }
            self.view_tagged.isHidden = false;
            self.const_tag_height.constant =  CGFloat(self.height_tag_view)
            self.const_tag_bottom.constant =  -CGFloat(self.height_tag_view)
            UIView.animate(withDuration: 0.5, animations: {
                self.const_tag_bottom.constant = 0.0
            }, completion: { result in
                self.view_tag_users.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
                self.tagged_table.reloadData()
            })
        }, onFailed: { err in
            self.showToast(message: err)
        })
    }
    
    @IBAction func onClickOutsideTag(_ sender: Any) {
        view_tagged.isHidden = true
    }
    
    @IBAction func onClickLookup(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LookUpViewController") as! LookUpViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickStats(_ sender: Any) {
        if AppData.user.type == Constants.TEAM_CLUB || AppData.user.type == Constants.STAFF {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ClubChartVC") as! ClubChartVC
            controller.user = AppData.user
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "StatsViewController") as! StatsViewController
            controller.user = AppData.user
            self.navigationController?.pushViewController(controller, animated: true)
        }        
    }
    
    @IBAction func onClickChat(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showStoryPublish(image: UIImage!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "StoryPublishVC") as! StoryPublishVC
        controller.photofile = image
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == table_view {
            return feeds.count
        } else if tableView == tagged_table {
            return tag_users.count
        }
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tagged_table {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaggedUserViewCell", for: indexPath) as! TaggedUserViewCell
            cell.index = indexPath.row
            cell.delegate = self
            cell.setCell(user: tag_users[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedViewCell", for: indexPath) as! NewsFeedViewCell
            cell.index = indexPath.row
            cell.delegate = self
            cell.setCell(feed: feeds[indexPath.row])
            return cell
        }
    }
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportSelectViewCell", for: indexPath) as! SportSelectViewCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(data: sports[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MainViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 65)
    }
    
}

extension MainViewController: SportSelectViewCellDelegate{
    func onTapSelect(index: Int){
        sports[index].selected = !sports[index].selected
        let sortedSport = sports.sorted(by : {
            (one: Sport, two: Sport) -> Bool in
            var m1 = one.selected ? 3000 : 0
            var m2 = two.selected ? 3000: 0
            if one.id == AppData.user.sport {
                m1 += 2000
            }
            if two.id == AppData.user.sport {
                m2 += 2000
            }
            let diff = (m2 - two.id) - (m1 - one.id)
            return diff < 0
        })
        sports = sortedSport
        collection_view.reloadData()
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    func onTapItem(st: Story){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "StoryShowVC") as! StoryShowVC
        controller.user = st.user
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainViewController: NewsFeedCellDelegate {
    func onClickProfile(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = feeds[index].user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onClickPlay(index: Int) {
        let feed = feeds[index]
        API.addViewFeed(feed: feed, onSuccess: { response in
            self.feeds[index].view_count = response.view_count
            if feed.type == Constants.YOUTUBE {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
                controller.video_title = self.feeds[index].title
                controller.video_url = self.feeds[index].video_url
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
                controller.video_title = self.feeds[index].title
                controller.video_url = self.feeds[index].video_url
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }, onFailed: { err in
            self.showToast(message: err)
        })
        
    }
    
    func onClickBookmark(index: Int) {
        API.saveBookmark(feed_id: feeds[index].id, onSuccess: { response in
            self.showToast(message: "Success")
            self.feeds[index].bookmark = response
            self.table_view.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }, onFailed: { error in
            self.showToast(message: error)
        })
    }
    
    func onClickMenu(index: Int) {
        report_sel = index
        let controller : ReportDialog = ReportDialog.init(nibName: "ReportDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.setTitle(text: "Report")
        present(controller, animated: true, completion: nil)
    }
    
    func onClickLike(index: Int) {
        API.addLikeFeed(feed: feeds[index], user: AppData.user, onSuccess: ({result in
            if result == true {
                self.feeds[index].like_count = self.feeds[index].like_count + 1
                self.feeds[index].like = true
            } else {
                self.feeds[index].like_count = self.feeds[index].like_count - 1
                self.feeds[index].like = false
            }
            self.table_view.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }), onFailed: ({error in
            self.showToast(message: error)
        }))
    }
    
    func onClickTagged(index: Int) {
        let feed = feeds[index]
        if !feed.tagged.isEmpty {
            showTaggedView(tagged: feed.tagged)
        }
    }
    
    func onClickArticle(index: Int) {
        let feed = feeds[index]
        if feed.type == Constants.NEWS {
            API.addViewFeed(feed: feed, onSuccess: { response in
                self.feeds[index].view_count = response.view_count
                //show Articles
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
                controller.feed = self.feeds[index]
                self.navigationController?.pushViewController(controller, animated: true)
            }, onFailed: { err in
                self.showToast(message: err)
            })
        }
    }
}

extension MainViewController:TaggedUserViewCellDelegate{
    func onClickProfileBtn(index: Int){
        view_tagged.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = tag_users[index]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainViewController: ReportDialogDelegate {
    func onClickOk(text: String) {
        if report_sel != -1 {
            hud.show(in: view)
            API.reportFeed(fid: feeds[report_sel].id, content: text, onSuccess: { response in
                self.hud.dismiss()
                self.refreshControl.beginRefreshing()
                self.refreshControl.sendActions(for: .valueChanged)
                self.showToast(message: "Your report was sent to manager successful")
            }, onFailed: { err in
                self.hud.dismiss()
                self.showToast(message: err)
            })
            report_sel = -1
        }
    }
}

extension MainViewController: UploadVideoDialogDelegate {
    func onClickYoutube() {
        let controller = UploadYoutubeDialog.init(nibName: "UploadYoutubeDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.isUploadedVideo = false
        present(controller, animated: true, completion: nil)
    }
    
    func onClickSubmit(title: String, video: URL!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PublishVideoVC") as! PublishVideoVC
        controller.video_url = video
        controller.video_title = title
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onClickStory(title: String) {
        let actionSheet = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .camera
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
        }))
        present(actionSheet, animated: true, completion: nil)
    }
}

extension MainViewController: UploadYoutubeDialogDelegate {
    func onClickVideo() {
        let controller = UploadVideoDialog.init(nibName: "UploadVideoDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.isUploadedVideo = false
        present(controller, animated: true, completion: nil)
    }
    
    func onClickSubmit(title: String, video: YoutubeVideoInfo) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PublishYoutubeVC") as! PublishYoutubeVC
        controller.video = video
        controller.video_title = title
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated:true, completion: nil)
        let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
        photoEditor.photoEditorDelegate = self
        photoEditor.image = photo
        //Stickers that the user will choose from to add on the image
        //Stickers that the user will choose from to add on the image
        for i in 0...10 {
            photoEditor.stickers.append(UIImage(named: i.description )!)
        }
        //Optional: To hide controls - array of enum control
        photoEditor.hiddenControls = [.share]
        //Optional: Colors for drawing and Text, If not set default values will be used
        //photoEditor.colors = [.red,.blue,.green]
        //Present the View Controller
        photoEditor.modalPresentationStyle = .overFullScreen
        photoEditor.modalTransitionStyle = .crossDissolve
        present(photoEditor, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension MainViewController: PhotoEditorDelegate{
    func doneEditing(image: UIImage) {
        self.showStoryPublish(image: image)
    }
    
    func canceledEditing() {
        if storyphoto != nil {
            self.showStoryPublish(image: storyphoto)
        }
    }
}

extension MainViewController:StoryPublishVCDelegate{
    func doneStory() {
        reloadData()
    }
}

extension MainViewController: PublishYoutubeVCDelegate{
    func doneYoutube(){
        refresh()
    }
}

extension MainViewController: PublishVideoVCDelegate{
    func doneVideo(){
        refresh()
    }
}

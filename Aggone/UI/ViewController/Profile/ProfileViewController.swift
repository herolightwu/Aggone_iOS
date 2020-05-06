//
//  ProfileViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/25/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import DropDown
import JHTAlertController
import AVKit
import MobileCoreServices
import JGProgressHUD
import FirebaseDatabase
import iOSPhotoEditor

class ProfileViewController: UIViewController {
    @IBOutlet var btn_menu: UIButton!
    @IBOutlet var image_avata: UIImageView!
    @IBOutlet weak var btn_plus: UIButton!
    @IBOutlet weak var avata_bg_view: UIView!
    @IBOutlet var label_name: UILabel!
    @IBOutlet weak var view_other: UIView!
    @IBOutlet weak var view_other_height: NSLayoutConstraint!
    @IBOutlet weak var btn_follow: UIButton!
    
    @IBOutlet weak var collection_view: UICollectionView!
    var summary: [Skill] = []
    
    @IBOutlet weak var btn_type: UIButton!
    @IBOutlet weak var btn_sport: UIButton!
    @IBOutlet weak var btn_specialty: UIButton!
    
    @IBOutlet weak var label_club: UILabel!
    @IBOutlet weak var label_category: UILabel!
    @IBOutlet weak var label_position: UILabel!
    @IBOutlet weak var lb_recommend_name: UILabel!
    @IBOutlet weak var lb_recommends: UILabel!
    @IBOutlet weak var img_flag: UIImageView!
    @IBOutlet weak var lb_city: UILabel!
    
    @IBOutlet weak var label_video: UILabel!
    @IBOutlet weak var image_video: UIImageView!
    @IBOutlet weak var label_prize: UILabel!
    @IBOutlet weak var image_prize: UIImageView!
    @IBOutlet weak var label_career: UILabel!
    @IBOutlet weak var image_career: UIImageView!
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var image_description: UIImageView!
    
    @IBOutlet weak var container_view: UIView!
    var pageViewController: UIPageViewController!
    
    var currentPageIndex: Int = 0
    var lastPendingViewControllerIndex: Int = 0
    
    //menu views
    @IBOutlet weak var view_menu: UIView!
    @IBOutlet weak var view_menu_self: UIView!
    @IBOutlet weak var view_menu_other: UIView!
    @IBOutlet weak var constraint_self_width: NSLayoutConstraint!
    @IBOutlet weak var constraint_other_width: NSLayoutConstraint!
    @IBOutlet weak var lb_other_block: UILabel!
    @IBOutlet weak var lb_other_report: UILabel!
    @IBOutlet weak var lb_modify_profile: UILabel!
    @IBOutlet weak var lb_change_password: UILabel!
    @IBOutlet weak var lb_menu_view: UILabel!
    @IBOutlet weak var lb_subscriptions: UILabel!
    @IBOutlet weak var lb_subscribers: UILabel!
    @IBOutlet weak var lb_ad: UILabel!
    @IBOutlet weak var lb_blocked_user: UILabel!
    @IBOutlet weak var lb_recorded: UILabel!
    @IBOutlet weak var lb_conditions: UILabel!
    @IBOutlet weak var lb_contact_us: UILabel!
    @IBOutlet weak var lb_sigout: UILabel!
    
    
    var user: User!
    
    var hud: JGProgressHUD!
    var storyphoto: UIImage!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
        setPageTitle(position:0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        setProfile()
    }
    
    func setViewController() {
        picker.delegate = self
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        view_menu.isHidden = true
        
        avata_bg_view.layer.cornerRadius = avata_bg_view.frame.height / 2
        avata_bg_view.layer.borderWidth = 2
        avata_bg_view.layer.borderColor = UIColor.from(hex: "83BE3D").cgColor
        avata_bg_view.clipsToBounds = true
        
        btn_sport.layer.cornerRadius = 10
        btn_sport.layer.borderWidth = 1
        btn_sport.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        btn_sport.clipsToBounds = true

        btn_type.layer.cornerRadius = 10
        btn_type.layer.borderWidth = 1
        btn_type.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        btn_type.clipsToBounds = true
        
        btn_specialty.layer.cornerRadius = 10
        btn_specialty.layer.borderWidth = 1
        btn_specialty.layer.borderColor = UIColor.from(hex: "82BF3F").cgColor
        btn_specialty.clipsToBounds = true
        
        btn_follow.layer.cornerRadius = 4
        btn_follow.clipsToBounds = true
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection_view.setCollectionViewLayout(layout, animated: true)
       
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.setViewControllers([newVideoViewController()],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        
        container_view.addSubview(pageViewController.view)
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: container_view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: container_view.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: container_view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: container_view.bottomAnchor)
            ])
        pageViewController.didMove(toParentViewController: self)
        
        lb_recommend_name.text = getString(key: "txt_recommendations")
        //menu setting
        lb_modify_profile.text = getString(key: "menu_modify_profile")
        lb_change_password.text = getString(key: "menu_change_password")
        lb_menu_view.text = getString(key: "menu_view")
        lb_ad.text = getString(key: "menu_ad")
        lb_subscriptions.text = getString(key: "menu_my_subscription")
        lb_subscribers.text = getString(key: "menu_my_subscribers")
        lb_recorded.text = getString(key: "menu_recorded")
        lb_blocked_user.text = getString(key: "menu_blocked_users")
        lb_conditions.text = getString(key: "menu_terms_conditions")
        lb_contact_us.text = getString(key: "menu_contact_us")
        lb_sigout.text = getString(key: "menu_sign_out")
        lb_other_block.text = getString(key: "menu_block")
        lb_other_report.text = getString(key: "menu_report")
        
        setProfile()
    }
    
    func setProfile() {
        if user.photo_url.isEmpty {
            image_avata.image = UIImage(named: "default_avata")
        } else {
            if user.photo_url.contains("http") {
                image_avata.sd_setImage(with: URL(string: user.photo_url), placeholderImage: nil)
            } else{
                image_avata.sd_setImage(with: URL(string: API.baseUrl + API.imgDirUrl + user.photo_url), placeholderImage: nil)
            }
        }
        label_name.text = user.username
        if user.id == AppData.user.id {
            btn_plus.isHidden = false
            view_other.isHidden = true
            view_other_height.constant = 20
        } else {
            btn_plus.isHidden = true
            view_other.isHidden = false
            view_other_height.constant = 50
            btn_follow.isHidden = true
            API.checkFollow(user_id: user.id, onSuccess: { result in
                self.btn_follow.isHidden = false
                if result {
                    self.btn_follow.setTitle(self.getString(key: "following"), for: .normal)
                } else {
                    self.btn_follow.setTitle(self.getString(key: "follow"), for: .normal)
                }
            }, onFailed: { error in
                self.showToast(message: error)
            })
        }
        btn_sport.setTitle(UIViewController.getSportName(sport: user.sport), for: .normal)
        btn_type.setTitle(getTypeName(type: user.type), for: .normal)
        btn_specialty.setTitle(user.contract, for: .normal)
        label_club.text = user.club
        label_category.text = user.category
        label_position.text = user.position
        lb_recommends.text = "\(user.recommends)"
        lb_city.text = user.city
        
        var country_str = locale_en(for:user.country)
        if country_str.isEmpty {
            country_str = user.country
        }
        let ccode = IsoCountryCodes.find(key: country_str)
        if ccode != nil && !ccode!.alpha2.isEmpty {
            img_flag.image = getCountryFlag(countryCode: ccode!.alpha2)
        }
        
        if user.type == Constants.COMPANY || user.type == Constants.AGENT ||
            user.type == Constants.STAFF{
            collection_view.isHidden = true
        } else {
            collection_view.isHidden = false
            API.getSportResultSummary(user: user, onSuccess: { response in
                self.summary = UIViewController.getSportSkills(sport: self.user.type == Constants.PLAYER ? self.user.sport : Constants.STATS_COACH, apiResult: response)
                self.collection_view.reloadData()
            }, onFailed: { error in
//                self.showToast(message: error)
            })
        }
        
        if user.id != AppData.user.id {
            API.viewProfile(uid: user.id, onSuccess: { response in
                self.lb_recommends.text = "\(response)"
                self.user.recommends = response
            }, onFailed: { err in
                
            })
        }
        
    }
    
    func newVideoViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileVideoViewController") as! ProfileVideoViewController
        controller.user = user
        controller.parentVC = self
        return controller
    }
    
    func newPrizeViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfilePrizeViewController") as! ProfilePrizeViewController
        controller.user = user
        return controller
    }
    
    func newCareerViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileCareerViewController") as! ProfileCareerViewController
        controller.user = user
        return controller
    }
    
    func newDescriptionViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileDescriptionViewController") as! ProfileDescriptionViewController
        controller.user = user
        controller.parentVC = self
        return controller
    }
    
    func newTeamViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileTeamVC") as! ProfileTeamVC
        controller.user = user
        controller.parentVC = self
        return controller
    }
    
    func newHistoryViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileHistoryVC") as! ProfileHistoryVC
        controller.user = user
        controller.parentVC = self
        return controller
    }
    
    func setPageTitle(position: Int) {
        if user.type > Constants.COACH {
            label_video.text = getString(key: "pf_news")
            label_prize.text = getString(key: "pf_trophies")
            label_career.text = getString(key: "pf_team")
            label_description.text = getString(key: "pf_history")
        } else {
            label_video.text = getString(key: "pf_videos")
            label_prize.text = getString(key: "pf_prizes")
            label_career.text = getString(key: "pf_career")
            label_description.text = getString(key: "pf_description")
        }
        label_video.textColor = UIColor.from(hex: "#AFAFAF")
        label_prize.textColor = UIColor.from(hex: "#AFAFAF")
        label_career.textColor = UIColor.from(hex: "#AFAFAF")
        label_description.textColor = UIColor.from(hex: "#AFAFAF")
        
        image_video.isHidden = true
        image_prize.isHidden = true
        image_career.isHidden = true
        image_description.isHidden = true
        
        currentPageIndex = position
        switch position {
        case 0:
            label_video.textColor = UIColor.from(hex: "#404040")
            image_video.isHidden = false
            break
        case 1:
            label_prize.textColor = UIColor.from(hex: "#404040")
            image_prize.isHidden = false
            break
        case 2:
            label_career.textColor = UIColor.from(hex: "#404040")
            image_career.isHidden = false
            break
        case 3:
            label_description.textColor = UIColor.from(hex: "#404040")
            image_description.isHidden = false
            break
        default: break
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickRecommend(_ sender: Any) {
        if user.id != AppData.user.id {
            hud.show(in: view)
            API.recommendUser(uid: user.id, onSuccess: {response in
                self.hud.dismiss()
                self.user.recommends = response;
                self.lb_recommends.text = "\(response)"
            }, onFailed: {err in
                self.hud.dismiss()
                self.showToast(message: err)
            })
        }
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        let controller : AddDialog = AddDialog.init(nibName: "AddDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
        
    @IBAction func onClickMenu(_ sender: Any) {
        if user.id == AppData.user.id {
            view_menu.isHidden = false
            view_menu_other.isHidden = true
            view_menu_self.isHidden = false
            constraint_self_width.constant = 0
            UIView.animate(withDuration: 1.0, animations: {
                self.constraint_self_width.constant = 270.0
            }, completion: { result in
                
            })
        } else{
            view_menu.isHidden = false
            view_menu_other.isHidden = false
            view_menu_self.isHidden = true
            constraint_other_width.constant = 0
            UIView.animate(withDuration: 1.0, animations: {
                self.constraint_other_width.constant = 270.0
            }, completion: { result in
                
            })
        }
    }
    
    @IBAction func onClickMessage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        controller.user = user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickStats(_ sender: Any) {
        if user.type == Constants.TEAM_CLUB || user.type == Constants.STAFF {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ClubChartVC") as! ClubChartVC
            controller.user = user
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "StatsViewController") as! StatsViewController
            controller.user = user
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func onClickResume(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ResumeVC") as! ResumeVC
        controller.user = user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickFollow(_ sender: Any) {
        btn_follow.isHidden = true
        if btn_follow.titleLabel?.text == getString(key: "follow") {
            API.addFollow(user_id: user.id, onSuccess: { response in
                if response {
                    self.btn_follow.setTitle(self.getString(key: "following"), for: .normal)                    
                }
                self.btn_follow.isHidden = false
            }, onFailed: { error in
                self.btn_follow.isHidden = false
                self.showToast(message: error)
            })
        } else {
            API.deleteFollow(user_id: user.id, onSuccess: { response in
                if response {
                    self.btn_follow.setTitle(self.getString(key: "follow"), for: .normal)
                }
                self.btn_follow.isHidden = false
            }, onFailed: { error in
                self.btn_follow.isHidden = false
                self.showToast(message: error)
            })
        }
    }
    
    @IBAction func onClickCareer(_ sender: Any) {
        if currentPageIndex == 2 {
            return
        }
        if user.type < Constants.TEAM_CLUB {
            pageViewController.setViewControllers([newCareerViewController()],
            direction: (currentPageIndex > 2 ? .reverse : .forward),
            animated: true,
            completion: nil)
        } else {
            pageViewController.setViewControllers([newTeamViewController()],
            direction: (currentPageIndex > 2 ? .reverse : .forward),
            animated: true,
            completion: nil)
        }
        
        setPageTitle(position: 2)
    }
    
    @IBAction func onClickVideo(_ sender: Any) {
        if currentPageIndex == 0 {
            return
        }
        pageViewController.setViewControllers([newVideoViewController()],
                                              direction: (currentPageIndex > 0 ? .reverse : .forward),
                                              animated: true,
                                              completion: nil)
        setPageTitle(position: 0)
    }
    
    @IBAction func onClickPrize(_ sender: Any) {
        if currentPageIndex == 1 {
            return
        }
        pageViewController.setViewControllers([newPrizeViewController()],
                                              direction: (currentPageIndex > 1 ? .reverse : .forward),
                                              animated: true,
                                              completion: nil)
        setPageTitle(position: 1)
    }
    
    @IBAction func onClickDescription(_ sender: Any) {
        if currentPageIndex == 3 {
            return
        }
        if user.type < Constants.TEAM_CLUB {
            pageViewController.setViewControllers([newDescriptionViewController()],
            direction: (currentPageIndex > 3 ? .reverse : .forward),
            animated: true,
            completion: nil)
        } else {
            pageViewController.setViewControllers([newHistoryViewController()],
            direction: (currentPageIndex > 3 ? .reverse : .forward),
            animated: true,
            completion: nil)
        }
        
        setPageTitle(position: 3)
    }
    
    func hideMenu(){
        if user.id == AppData.user.id {
            UIView.animate(withDuration: 0.7, animations: {
                self.constraint_self_width.constant = 0.0
            }, completion: { result in
                self.view_menu.isHidden = true
                self.view_menu_self.isHidden = true
            })
        } else {
            UIView.animate(withDuration: 0.7, animations: {
                self.constraint_other_width.constant = 0.0
            }, completion: { result in
                self.view_menu.isHidden = true
                self.view_menu_other.isHidden = true
            })
        }
    }
    
    @IBAction func onClickMenuOutside(_ sender: Any) {
        hideMenu()
    }
    
    @IBAction func onClickBlock(_ sender: Any) {
        self.view_menu.isHidden = true
        API.addBlock(blocked_user_id: user.id, onSuccess: ({ result in
            self.showToast(message: "Blocked")
        }), onFailed: ({ error in
            self.showToast(message: error)
        }))
    }
    
    @IBAction func onClickReport(_ sender: Any) {
        self.view_menu.isHidden = true
        let controller : ReportDialog = ReportDialog.init(nibName: "ReportDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.setTitle(text: "Report")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onClickMenu_Modify_Profile(_ sender: Any) {
        self.view_menu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        controller.user = self.user
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMenu_Change_Password(_ sender: Any) {
        self.view_menu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMenu_View(_ sender: Any) {
        self.view_menu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AudienceVC") as! AudienceVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMenu_Subscriptions(_ sender: Any) {
        self.view_menu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SubscriptionViewController") as! SubscriptionViewController
        controller.user = self.user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMenu_Subscribers(_ sender: Any) {
        self.view_menu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SubscriberViewController") as! SubscriberViewController
        controller.user = self.user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMenu_Ad(_ sender: Any) {
        self.view_menu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AdvertismentVC") as! AdvertismentVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMenu_Blocked_Users(_ sender: Any) {
        self.view_menu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BlockedUsersViewController") as! BlockedUsersViewController
        controller.user = self.user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMenu_Recorded(_ sender: Any) {
        self.view_menu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RecordedViewController") as! RecordedViewController
        controller.user = self.user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMenu_Conditions(_ sender: Any) {
        self.view_menu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMenu_Contact_Us(_ sender: Any) {
        self.view_menu.isHidden = true
        self.showJHTAlertOkayAction(message: "Need help for a request or a problem help.aggone@gmail.com", action: nil)
    }
    
    @IBAction func onClickMenu_Signout(_ sender: Any) {
        self.view_menu.isHidden = true
        UserDefaults.standard.set(false, forKey: Constants.LOGIN_ISLOGGEDIN)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showStoryPublish(image: UIImage!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "StoryPublishVC") as! StoryPublishVC
        controller.photofile = image
//        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickAvatr(_ sender: Any) {
        let st = AppData.last_stories[user.sport]
        if st != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "StoryShowVC") as! StoryShowVC
            controller.user = user
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
}

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return summary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as! ResultCell
        cell.index = indexPath.row
        cell.setCell(skill: summary[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension ProfileViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 55)
    }
}

extension ProfileViewController : ReportDialogDelegate {
    func onClickOk(text: String) {
        hud.show(in: view)
        API.reportUser(uid: user.id, content: text, onSuccess: { response in
            self.hud.dismiss()
            self.showToast(message: "Your report was sent to manager successful")
        }, onFailed: { err in
            self.hud.dismiss()
        })
    }
}

extension ProfileViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func getPageViewController(position: Int)->UIViewController {
        switch position {
        case 0:
            return newVideoViewController()
        case 1:
            return newPrizeViewController()
        case 2:
            if user.type < Constants.TEAM_CLUB {
                return newCareerViewController()
            } else {
                return newTeamViewController()
            }
        case 3:
            if user.type < Constants.TEAM_CLUB {
                return newDescriptionViewController()
            } else{
                return newHistoryViewController()
            }
            
        default:
            return UIViewController()
        }
    }
    
    func getPageIndex(viewController: UIViewController)->Int {
        if viewController is ProfileVideoViewController {
            return 0
        }
        if viewController is ProfilePrizeViewController {
            return 1
        }
        if viewController is ProfileCareerViewController {
            return 2
        }
        if viewController is ProfileDescriptionViewController {
            return 3
        }
        if viewController is ProfileTeamVC {
            return 2
        }
        if viewController is ProfileHistoryVC {
            return 3
        }
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = getPageIndex(viewController: viewController)
        let previousIndex = index - 1
        if previousIndex >= 0 {
            return getPageViewController(position: previousIndex)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = getPageIndex(viewController: viewController)
        let nextIndex = index + 1
        if nextIndex < 4 {
            return getPageViewController(position: nextIndex)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        lastPendingViewControllerIndex = getPageIndex(viewController: pendingViewControllers.first!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            self.setPageTitle(position: lastPendingViewControllerIndex)
        }
    }
}

extension ProfileViewController: AddDialogDelegate {
    func onClickUploadVideo() {
        let controller = UploadVideoDialog.init(nibName: "UploadVideoDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.isUploadedVideo = false
        present(controller, animated: true, completion: nil)
    }
    
    func onClickAddPrize() {
        let controller = AddPrizeDialog.init(nibName: "AddPrizeDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.icon = -1
        present(controller, animated: true, completion: nil)
    }
    
    func onClickCareerRoadmap() {
        let controller = AddCareerDialog.init(nibName: "AddCareerDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.isUploadedLogo = false
        present(controller, animated: true, completion: nil)
    }
    
    func onClickAddDescription() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EditDescriptionViewController") as! EditDescriptionViewController
        controller.user = user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onClickAddNews() {
        let controller = AddNewsDialog.init(nibName: "AddNewsDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func onClickAddHistory() {
        let controller = AddHistoryDialog.init(nibName: "AddHistoryDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.sTitle = getString(key: "pf_history")
        present(controller, animated: true, completion: nil)
    }
    
    func onClickRemove() {
        
    }
}

extension ProfileViewController: UploadVideoDialogDelegate {
    func onClickSubmit(title: String, video: URL!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PublishVideoVC") as! PublishVideoVC
        controller.video_url = video
        controller.video_title = title
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onClickYoutube() {
        let controller = UploadYoutubeDialog.init(nibName: "UploadYoutubeDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        controller.isUploadedVideo = false
        present(controller, animated: true, completion: nil)
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

extension ProfileViewController: UploadYoutubeDialogDelegate {
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

extension ProfileViewController: AddPrizeDialogDelegate {
    func onClickSubmit(title: String, club: String, year: String, icon: Int) {
        let prize = Prize()
        prize.user_id = user.id
        prize.title = title
        prize.club = club
        prize.year = year
        prize.icon = icon
        hud.show(in: view)
        API.savePrize(prize: prize, onSuccess: { response in
            self.hud.dismiss()
        }, onFailed: { error in
            self.hud.dismiss()
            self.showToast(message: error)
        })
    }
}

extension ProfileViewController: AddCareerDialogDelegate {
    func onClickSubmit(club_name: String, sport: String, day: Int, month: Int, year: Int, tday: Int, tmonth: Int, tyear: Int, position: String, location: String, has_image: Bool, logo: Data) {
        if has_image {
            let file_name:String = "photo_" + AppData.user.id + "\(UInt(Date().timeIntervalSince1970))"
            hud.show(in: view)
            API.uploadImage(name: file_name, image: logo, onSuccess: { response in
                let career = Career()
                career.user_id = self.user.id
                career.club = club_name
                career.sport = sport
                career.day = day
                career.month = month
                career.year = year
                career.tday = tday
                career.tmonth = tmonth
                career.tyear = tyear
                career.position = position
                career.location = location
                career.logo = response
                API.saveCareer(career: career, onSuccess: { response in
                    self.hud.dismiss()
                }, onFailed: { error in
                    self.hud.dismiss()
                    self.showToast(message: error)
                })
            }, onFailed: { error in
                self.hud.dismiss()
                self.showToast(message: error)
            })
        } else {
            let career = Career()
            career.user_id = self.user.id
            career.club = club_name
            career.sport = sport
            career.day = day
            career.month = month
            career.year = year
            career.tday = tday
            career.tmonth = tmonth
            career.tyear = tyear
            career.position = position
            career.location = location
            career.logo = ""
            hud.show(in: view)
            API.saveCareer(career: career, onSuccess: { response in
                self.hud.dismiss()
            }, onFailed: { error in
                self.hud.dismiss()
                self.showToast(message: error)
            })
        }
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func updatedProfile() {
        self.user = AppData.user
        setProfile()
    }
}

extension ProfileViewController: AddNewsDialogDelegate{
    func onNewsDone() {
        
    }
}

extension ProfileViewController: AddHistoryDialogDelegate{
    func onHistoryDone() {
        self.user = AppData.user
        setProfile()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.storyphoto = photo
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

extension ProfileViewController: PhotoEditorDelegate{
    func doneEditing(image: UIImage) {
        self.showStoryPublish(image: image)
    }
    
    func canceledEditing() {
        if storyphoto != nil {
            self.showStoryPublish(image: storyphoto)
        }
    }
}

extension ProfileViewController: PublishYoutubeVCDelegate{
    func doneYoutube(){
        if currentPageIndex == 0 {
            return
        }
    }
}

extension ProfileViewController: PublishVideoVCDelegate{
    func doneVideo(){
        if currentPageIndex == 0 {
            return
        }
    }
}

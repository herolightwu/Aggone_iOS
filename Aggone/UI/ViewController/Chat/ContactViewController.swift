//
//  ContactViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/24/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    @IBOutlet weak var image_message: UIImageView!
    @IBOutlet weak var image_notification: UIImageView!
    @IBOutlet weak var label_message: UILabel!
    @IBOutlet weak var label_notification: UILabel!
    
    @IBOutlet weak var container_view: UIView!
    var pageViewController: UIPageViewController!
    
    var currentPageIndex: Int = 0
    var lastPendingViewControllerIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    func setViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.setViewControllers([newMessageViewController()],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        setPageTitle(position: 0)
        container_view.addSubview(pageViewController.view)
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: container_view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: container_view.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: container_view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: container_view.bottomAnchor)
            ])
        pageViewController.didMove(toParentViewController: self)
    }
    
    func setPageTitle(position: Int) {
        currentPageIndex = position
        switch position {
        case 0:
            image_message.image = UIImage(named: "message_tab_active")
            image_notification.image = UIImage(named: "message_tab_normal")
            label_message.alpha = 1.0
            label_notification.alpha = 0.7
            break
        case 1:
            image_message.image = UIImage(named: "message_tab_normal")
            image_notification.image = UIImage(named: "message_tab_active")
            label_message.alpha = 0.7
            label_notification.alpha = 1.0
            break
        default: break
        }
    }
    
    func newMessageViewController()->UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
        controller.delegate = self
        return controller
    }
    
    func newNotificationViewController()->UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        controller.delegate = self
        return controller
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickAddContact(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddContactViewController") as! AddContactViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickMessage(_ sender: Any) {
        if currentPageIndex == 0 {
            return
        }
        pageViewController.setViewControllers([newMessageViewController()],
                                              direction: (currentPageIndex > 0 ? .reverse : .forward),
                                              animated: true,
                                              completion: nil)
        setPageTitle(position: 0)
    }
    
    @IBAction func onClickNotification(_ sender: Any) {
        if currentPageIndex == 1 {
            return
        }
        pageViewController.setViewControllers([newNotificationViewController()],
                                              direction: (currentPageIndex > 1 ? .reverse : .forward),
                                              animated: true,
                                              completion: nil)
        setPageTitle(position: 1)
    }
    
    @IBAction func onClickMain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(controller, animated: true)
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
    
}

extension ContactViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func getPageViewController(position: Int)->UIViewController {
        switch position {
        case 0:
            return newMessageViewController()
        case 1:
            return newNotificationViewController()
        default:
            return UIViewController()
        }
    }
    
    func getPageIndex(viewController: UIViewController)->Int {
        if viewController is MessageViewController {
            return 0
        }
        if viewController is NotificationViewController {
            return 1
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
        if nextIndex < 2 {
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

extension ContactViewController: MessageViewControllerDelegate {
    func onChat(user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        controller.user = user
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ContactViewController: NotificationViewControllerDelegate {
    func onClickProfile(user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = user
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

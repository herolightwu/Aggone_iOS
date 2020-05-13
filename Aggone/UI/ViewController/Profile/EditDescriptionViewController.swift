//
//  EditDescriptionViewController.swift
//  Aggone
//
//  Created by APPLE on 2019/4/2.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit

class EditDescriptionViewController: UIViewController {

    @IBOutlet weak var label_psychomotility: UILabel!
    @IBOutlet weak var view_psychomotility: UIView!
    @IBOutlet weak var label_individual_technique: UILabel!
    @IBOutlet weak var view_individual_technique: UIView!
    @IBOutlet weak var label_physical_quantities: UILabel!
    @IBOutlet weak var view_physical_quantities: UIView!
    @IBOutlet weak var label_tactics: UILabel!
    @IBOutlet weak var view_tactics: UIView!
    
    @IBOutlet weak var container_view: UIView!
    var pageViewController: UIPageViewController!
    
    var user: User!
    
    var currentPageIndex: Int = 0
    var lastPendingViewControllerIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }

    func setViewController() {
        if user.type == Constants.PLAYER {
            label_psychomotility.text = getString(key: "category_1")
            label_individual_technique.text = getString(key: "category_2")
            label_physical_quantities.text = getString(key: "category_3")
            label_tactics.text = getString(key: "category_4")
        } else {
            label_psychomotility.text = getString(key: "ccategory_1")
            label_individual_technique.text = getString(key: "ccategory_2")
            label_physical_quantities.text = getString(key: "ccategory_3")
            label_tactics.text = getString(key: "ccategory_4")
        }
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.setViewControllers([newPsychomotilityViewController()],
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
    
    func newPsychomotilityViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SkillViewController") as! SkillViewController
        controller.page_index = 0
        controller.user = user
        if user.type == Constants.PLAYER {
            controller.ids = [
                Constants.DESCRIPTION1,
                Constants.DESCRIPTION2,
                Constants.DESCRIPTION3,
                Constants.DESCRIPTION4,
                Constants.DESCRIPTION5,
                Constants.DESCRIPTION6]
            controller.labels = [
                getString(key: "description_1"),
                getString(key: "description_2"),
                getString(key: "description_3"),
                getString(key: "description_4"),
                getString(key: "description_5"),
                getString(key: "description_6"),
            ]
        } else {
            controller.ids = [
                Constants.CDESCRIPTION1,
                Constants.CDESCRIPTION2,
                Constants.CDESCRIPTION3,
                Constants.CDESCRIPTION4,
                Constants.CDESCRIPTION5,
                Constants.CDESCRIPTION6]
            controller.labels = [
                getString(key: "cdescription_1"),
                getString(key: "cdescription_2"),
                getString(key: "cdescription_3"),
                getString(key: "cdescription_4"),
                getString(key: "cdescription_5"),
                getString(key: "cdescription_6"),
            ]
        }
        return controller
    }
    
    func newIndividualTechniqueViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SkillViewController") as! SkillViewController
        controller.page_index = 1
        controller.user = user
        if user.type == Constants.PLAYER {
            controller.ids = [
                Constants.DESCRIPTION7,
                Constants.DESCRIPTION8,
                Constants.DESCRIPTION9,
                Constants.DESCRIPTION10,
                Constants.DESCRIPTION11,
                Constants.DESCRIPTION12]
            controller.labels = [
                getString(key: "description_7"),
                getString(key: "description_8"),
                getString(key: "description_9"),
                getString(key: "description_10"),
                getString(key: "description_11"),
                getString(key: "description_12"),
            ]
        } else {
            controller.ids = [
                Constants.CDESCRIPTION7,
                Constants.CDESCRIPTION8,
                Constants.CDESCRIPTION9,
                Constants.CDESCRIPTION10,
                Constants.CDESCRIPTION11,
                Constants.CDESCRIPTION12]
            controller.labels = [
                getString(key: "cdescription_7"),
                getString(key: "cdescription_8"),
                getString(key: "cdescription_9"),
                getString(key: "cdescription_10"),
                getString(key: "cdescription_11"),
                getString(key: "cdescription_12"),
            ]
        }
        return controller
    }
    
    func newPhysicalQuantitiesViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SkillViewController") as! SkillViewController
        controller.page_index = 2
        controller.user = user
        if user.type == Constants.PLAYER {
            controller.ids = [
                Constants.DESCRIPTION13,
                Constants.DESCRIPTION14,
                Constants.DESCRIPTION15,
                Constants.DESCRIPTION16,
                Constants.DESCRIPTION17,
                Constants.DESCRIPTION18]
            controller.labels = [
                getString(key: "description_13"),
                getString(key: "description_14"),
                getString(key: "description_15"),
                getString(key: "description_16"),
                getString(key: "description_17"),
                getString(key: "description_18"),
            ]
        } else {
            controller.ids = [
                Constants.CDESCRIPTION13,
                Constants.CDESCRIPTION14,
                Constants.CDESCRIPTION15,
                Constants.CDESCRIPTION16,
                Constants.CDESCRIPTION17,
                Constants.CDESCRIPTION18]
            controller.labels = [
                getString(key: "cdescription_13"),
                getString(key: "cdescription_14"),
                getString(key: "cdescription_15"),
                getString(key: "cdescription_16"),
                getString(key: "cdescription_17"),
                getString(key: "cdescription_18"),
            ]
        }
        return controller
    }
    
    func newTacticsViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SkillViewController") as! SkillViewController
        controller.page_index = 3
        controller.user = user
        if user.type == Constants.PLAYER {
            controller.ids = [
                Constants.DESCRIPTION19,
                Constants.DESCRIPTION20,
                Constants.DESCRIPTION21,
                Constants.DESCRIPTION22,
                Constants.DESCRIPTION23,
                Constants.DESCRIPTION24]
            controller.labels = [
                getString(key: "description_19"),
                getString(key: "description_20"),
                getString(key: "description_21"),
                getString(key: "description_22"),
                getString(key: "description_23"),
                getString(key: "description_24"),
            ]
        } else {
            controller.ids = [
                Constants.CDESCRIPTION19,
                Constants.CDESCRIPTION20,
                Constants.CDESCRIPTION21,
                Constants.CDESCRIPTION22,
                Constants.CDESCRIPTION23,
                Constants.CDESCRIPTION24]
            controller.labels = [
                getString(key: "cdescription_19"),
                getString(key: "cdescription_20"),
                getString(key: "cdescription_21"),
                getString(key: "cdescription_22"),
                getString(key: "cdescription_23"),
                getString(key: "cdescription_24"),
            ]
        }
        return controller
    }
    
    func setPageTitle(position: Int) {

        label_psychomotility.alpha = 0.5
        label_individual_technique.alpha = 0.5
        label_physical_quantities.alpha = 0.5
        label_tactics.alpha = 0.5
        
        view_psychomotility.isHidden = true
        view_individual_technique.isHidden = true
        view_physical_quantities.isHidden = true
        view_tactics.isHidden = true
        
        currentPageIndex = position
        switch position {
        case 0:
            label_psychomotility.alpha = 1
            view_psychomotility.isHidden = false
            break
        case 1:
            label_individual_technique.alpha = 1
            view_individual_technique.isHidden = false
            break
        case 2:
            label_physical_quantities.alpha = 1
            view_physical_quantities.isHidden = false
            break
        case 3:
            label_tactics.alpha = 1
            view_tactics.isHidden = false
            break
        default: break
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        actionBack()
    }
    
    @IBAction func onClickPsychomotility(_ sender: Any) {
        if currentPageIndex == 0 {
            return
        }
        pageViewController.setViewControllers([newPsychomotilityViewController()],
                                              direction: (currentPageIndex > 0 ? .reverse : .forward),
                                              animated: true,
                                              completion: nil)
        setPageTitle(position: 0)
    }
    
    @IBAction func onClickIndividualTechnique(_ sender: Any) {
        if currentPageIndex == 1 {
            return
        }
        pageViewController.setViewControllers([newIndividualTechniqueViewController()],
                                              direction: (currentPageIndex > 1 ? .reverse : .forward),
                                              animated: true,
                                              completion: nil)
        setPageTitle(position: 1)
    }
    
    @IBAction func onClickPhysicalQuantities(_ sender: Any) {
        if currentPageIndex == 2 {
            return
        }
        pageViewController.setViewControllers([newPhysicalQuantitiesViewController()],
                                               direction: (currentPageIndex > 2 ? .reverse : .forward),
            animated: true,
            completion: nil)
            setPageTitle(position: 2)
    }
    
    @IBAction func onClickTactics(_ sender: Any) {
        if currentPageIndex == 3 {
            return
        }
        pageViewController.setViewControllers([newTacticsViewController()],
                                              direction: (currentPageIndex > 3 ? .reverse : .forward),
                                              animated: true,
                                              completion: nil)
        setPageTitle(position: 3)
    }    
}

extension EditDescriptionViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func getPageViewController(position: Int)->UIViewController {
        switch position {
        case 0:
            return newPsychomotilityViewController()
        case 1:
            return newIndividualTechniqueViewController()
        case 2:
            return newPhysicalQuantitiesViewController()
        case 3:
            return newTacticsViewController()
        default:
            return UIViewController()
        }
    }
    
    func getPageIndex(viewController: UIViewController)->Int {
        if viewController is SkillViewController {
            return (viewController as! SkillViewController).page_index
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

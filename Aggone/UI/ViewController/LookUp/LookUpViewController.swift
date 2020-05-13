//
//  LookUpViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/22/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

class LookUpViewController: UIViewController {

    @IBOutlet weak var view_filter: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_filter.layer.cornerRadius = 13
        view_filter.clipsToBounds = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickFilter(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickCreateAd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateAdmobViewController") as! CreateAdmobViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickLookingClub(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LookingClubViewController") as! LookingClubViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickLookingPlayer(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LookingPlayerViewController") as! LookingPlayerViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onClickMain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
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
    
    @IBAction func onClickChats(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

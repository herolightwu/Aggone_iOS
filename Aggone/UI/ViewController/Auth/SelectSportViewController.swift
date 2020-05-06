//
//  SelectSportViewController.swift
//  Aggone
//
//  Created by tiexiong on 2/24/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class SelectSportViewController: UIViewController {

    @IBOutlet weak var collection_view: UICollectionView!
    var sports: [Sport] = []
    
    var email: String!
    var password: String!
    var signup_mode : Int = Constants.SIGNUP_EMAIL
    
    var hud: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }

    func setViewController() {
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        sports = getAllSports()
        collection_view.reloadData()
    }

    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelectSportViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportViewCell", for: indexPath) as! SportViewCell
        cell.index = indexPath.row
        cell.setCell(data: sports[indexPath.row], prefex: getString(key: "select"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hud.show(in: view)
        if signup_mode == Constants.SIGNUP_EMAIL {
            API.signupWithEmailAndPassword(email: email, password: password, onSuccess: ({user in
                user.sport = self.sports[indexPath.row].id
                user.username = AppData.user.username
                user.year = AppData.user.year
                user.month = AppData.user.month
                user.day = AppData.user.day
                user.age = AppData.user.age
                user.type = AppData.user.type
                user.city = AppData.user.city
                user.country = AppData.user.country
                user.gender = AppData.user.gender
                user.weight = Constants.WEIGHT_DEFAULT
                user.height = Constants.HEIGHT_DEFAULT
                API.updateUser(user: user, onSuccess: ({ new_user in
                    self.hud.dismiss()
                    AppData.user = new_user
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
                    controller.modalPresentationStyle = .overFullScreen
                    controller.modalTransitionStyle = .crossDissolve
                    self.navigationController?.present(controller, animated: true, completion: nil)
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.window?.rootViewController = controller
                }), onFailed: ({new_error in
                    self.hud.dismiss()
                    self.showToast(message: new_error)
                }))
            }), onFailed: ({ error in
                self.hud.dismiss()
                self.showToast(message: error)
            }))
        } else{
            let user = User()
            user.email = AppData.user.email
            user.sport = self.sports[indexPath.row].id
            user.username = AppData.user.username
            user.year = AppData.user.year
            user.month = AppData.user.month
            user.day = AppData.user.day
            user.age = AppData.user.age
            user.type = AppData.user.type
            user.city = AppData.user.city
            user.country = AppData.user.country
            user.gender = AppData.user.gender
            user.weight = Constants.WEIGHT_DEFAULT
            user.height = Constants.HEIGHT_DEFAULT
            API.updateUser(user: user, onSuccess: ({ new_user in
                self.hud.dismiss()
                AppData.user = new_user
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
                controller.modalPresentationStyle = .overFullScreen
                controller.modalTransitionStyle = .crossDissolve
                self.navigationController?.present(controller, animated: true, completion: nil)
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = controller
            }), onFailed: ({new_error in
                self.hud.dismiss()
                self.showToast(message: new_error)
            }))
        }
        
    }
}


extension SelectSportViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 90)
    }
    
}

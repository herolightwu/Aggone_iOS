//
//  ProfilePrizeViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/29/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit
import DropDown

class ProfilePrizeViewController: UIViewController {

    @IBOutlet weak var collection_view: UICollectionView!
    
    var user: User!
    var prizes: [Prize] = []
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collection_view.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func refresh() {
        API.getAllPrizeByUserid(user_id: user.id, onSuccess: { response in
            self.prizes = response
            self.collection_view.reloadData()
            self.refreshControl.endRefreshing()
        }, onFailed: { error in
            self.showToast(message: error)
            self.refreshControl.endRefreshing()
        })
    }
}

extension ProfilePrizeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrizeCell", for: indexPath) as! PrizeCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(prize: prizes[indexPath.row])
        return cell
    }
}

extension ProfilePrizeViewController: PrizeCellDelegate {
    func onLongClick(index: Int) {
        if user.id != AppData.user.id { return }
        let controller : DeleteDialog = DeleteDialog.init(nibName: "DeleteDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.handler = { () in
            API.deletePrize(prize: self.prizes[index], onSuccess: { response in
                self.prizes.remove(at: index)
                self.collection_view.reloadData()
            }, onFailed: { error in
                self.showToast(message: error)
            })
        }
        present(controller, animated: true, completion: nil)
    }
}

extension ProfilePrizeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
}

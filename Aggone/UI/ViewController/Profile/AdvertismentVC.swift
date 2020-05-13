//
//  AdvertismentVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/24/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

class AdvertismentVC: UIViewController {
    
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var lb_title: UILabel!
    
    var admobs:[Admob] = []
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lb_title.text = getString(key: "menu_ad")
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        table_view.addSubview(refreshControl)
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
        API.getAllAdmobs(onSuccess: { response in
            self.admobs.removeAll()
            self.admobs = response
            self.table_view.reloadData()
            self.refreshControl.endRefreshing()
        }, onFailed: { err in
            self.showToast(message: err)
            self.refreshControl.endRefreshing()
        })
    }

    @IBAction func onClickBacl(_ sender: Any) {
        self.actionBack()
    }
    
    func deleteAdmobItem(ind: Int){
        let controller : DeleteDialog = DeleteDialog.init(nibName: "DeleteDialog", bundle: nil)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.handler = { () in
            API.deleteAdvert(ad_id: self.admobs[ind].id, onSuccess: {response in
                self.admobs.remove(at: ind)
                self.table_view.reloadData()
            }, onFailed: {error in
                self.showToast(message: error)
            })
        }
        present(controller, animated: true, completion: nil)
    }
}

extension AdvertismentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return admobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdTVCell", for: indexPath) as! AdTVCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.setCell(admob: admobs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        controller.user = admobs[indexPath.row].user
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension AdvertismentVC: AdTVCellDelegates{
    func onClickDelete(index: Int) {
        self.deleteAdmobItem(ind: index)
    }
}

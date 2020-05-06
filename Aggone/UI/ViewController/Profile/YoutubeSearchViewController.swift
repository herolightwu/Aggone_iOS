//
//  YoutubeSearchViewController.swift
//  Aggone
//
//  Created by tiexiong on 5/31/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

protocol YoutubeSearchViewControllerDelegate {
    func onFindLink(youtubeVideoInfo: YoutubeVideoInfo)
}

class YoutubeSearchViewController: UIViewController {

    @IBOutlet var table_view: UITableView!
    @IBOutlet weak var text_search: UITextField!
    
    var videos:[YoutubeVideoInfo] = []
    var delegate: YoutubeSearchViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        text_search.addTarget(self, action: #selector(onSearch(_:)), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickClear(_ sender: Any) {
        text_search.text = ""
        onSearch(text_search)
    }
    
    @objc func onSearch(_ textField: UITextField) {
        let key = textField.text!
        API.getYoutubeList(key: key, onSuccess: ({ videos in
            self.videos = videos
            DispatchQueue.main.async {
                self.table_view.reloadData()
            }
        }), onFailed: ({ error in
            self.showToast(message: error)
        }))
    }

}

extension YoutubeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YoutubeTableViewCell", for: indexPath) as! YoutubeTableViewCell
        
        cell.setCell(video: videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.actionBack(completion: {
            if self.delegate != nil {
                self.delegate.onFindLink(youtubeVideoInfo: self.videos[indexPath.row])
            }
        })
    }
}

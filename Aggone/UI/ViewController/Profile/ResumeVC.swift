//
//  ResumeVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 5/3/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD
import Alamofire
import MobileCoreServices

class ResumeVC: UIViewController {
    
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var lb_title: UILabel!
    
    var user:User!
    
    var resumes:[Resume] = []
    var hud:JGProgressHUD!
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setViewController(){
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        
        if user.id == AppData.user.id {
            lb_title.isHidden = false
        } else{
            lb_title.isHidden = true
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection_view.setCollectionViewLayout(layout, animated: true)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collection_view.addSubview(refreshControl)
        
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    @objc func refresh() {
        API.getAllResumes(user_id: user.id, onSuccess: { response in
            self.refreshControl.endRefreshing()
            self.resumes = response
            self.collection_view.reloadData()
        }, onFailed: { err in
            self.refreshControl.endRefreshing()
            self.showToast(message: err)
        })
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    func downloadResumefile(filename: String!){
        let downloadpath = API.baseUrl + API.resumeDirUrl + filename
        let encodedStr = (downloadpath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        hud.show(in: view)
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent(filename)
            return (documentsURL, [.removePreviousFile])
        }
        Alamofire.download(encodedStr, to: destination)
            .downloadProgress { progress in

            }
            .responseData { response in
                self.hud.dismiss()
                switch response.result{
                case .success:
                    if response.destinationURL != nil {//, let filePath = response.destinationURL?.absoluteString
                        self.openPDF(filepath:response.destinationURL)
                    }
                    break
                case .failure:
                    self.showToast(message: "Download Failed")
                    break
                }

        }
    }
    
    func openPDF(filepath: URL!){
        let dc = UIDocumentInteractionController(url: filepath) //URL(fileURLWithPath: filepath)
        dc.delegate = self
        dc.presentPreview(animated: true)
    }
    
    func uploadResumePDF(url: URL!){
        let filename = user.username + "_\(Int64(Date().timeIntervalSince1970)).pdf"
        var data: Data = Data()
        data = NSData.init(contentsOf: url)! as Data
        hud.show(in: view)
        API.uploadResume(name: filename, pdf_file: data, onSuccess: { response in
            self.hud.dismiss()
            self.refreshControl.beginRefreshing()
            self.refreshControl.sendActions(for: .valueChanged)
        }, onFailed: {err in
            self.hud.dismiss()
            self.showToast(message: "Try to upload pdf file again")
        })
        
    }
    
}

extension ResumeVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if user.id == AppData.user.id {
            return resumes.count + 1
        } else{
            return resumes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == resumes.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResumeCVC", for: indexPath) as! ResumeCVC
            cell.index = indexPath.row
            cell.delegate = self
            cell.user = self.user
            cell.setCell(data: nil)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResumeCVC", for: indexPath) as! ResumeCVC
            cell.index = indexPath.row
            cell.delegate = self
            cell.user = self.user
            cell.setCell(data: resumes[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == resumes.count {
            let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            documentPicker.delegate = self
            documentPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(documentPicker, animated: true, completion: nil)
        }
    }
}

extension ResumeVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ww = collectionView.layer.frame.width - 40
        return CGSize(width: ww/2 , height: ww/2 + 95)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

extension ResumeVC: ResumeCVCDelegate{
    func onDownload(ind: Int!) {
        if user.id == AppData.user.id {
            let controller : DeleteDialog = DeleteDialog.init(nibName: "DeleteDialog", bundle: nil)
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            controller.handler = { () in
                self.hud.show(in: self.view)
                API.deleteResume(r_id: self.resumes[ind].id, onSuccess: { response in
                    self.hud.dismiss()
                    self.resumes.remove(at: ind)
                    self.collection_view.reloadData()
                }, onFailed: { err in
                    self.hud.dismiss()
                    self.showToast(message: err)
                })
            }
            self.present(controller, animated: true, completion: nil)
        } else {
            downloadResumefile(filename: resumes[ind].resume_url)
        }
    }
}

extension ResumeVC: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

extension ResumeVC: UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
          guard let myURL = urls.first else {
               return
          }
          print("import result : \(myURL)")
        self.uploadResumePDF(url: myURL)
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("view was cancelled")
            //dismiss(animated: true, completion: nil)
    }
}

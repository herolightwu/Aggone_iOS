//
//  EditStrengthVC.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/22/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit
import JGProgressHUD

class EditStrengthVC: UIViewController {

    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var lb_sport: UILabel!
    @IBOutlet weak var txt_search: UITextField!
    
    var strengths: [String] = []
    var filteredStrings: [String] = []
    var sel_strengths: [String] = []
    
    var hud: JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait"
        txt_search.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        strengths = configureStrength(sid: AppData.user.sport)
        filteredStrings = strengths
        lb_sport.text = UIViewController.getSportName(sport: AppData.user.sport)
        getAllStrengths()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if txt_search.text!.isEmpty {
            filteredStrings = strengths
        } else{
            filteredStrings = strengths.filter { item in
                return item.lowercased().contains(txt_search.text!.lowercased())
            }
        }
        table_view.reloadData()
    }

    @IBAction func onClickBack(_ sender: Any) {
        self.actionBack()
    }
    
    @IBAction func onClickApply(_ sender: Any) {
        var sel_inds = ""
        var index: Int = 0
        for ss in strengths {
            if sel_strengths.count > 0 {
                if sel_strengths[0] == ss {
                    if sel_inds.isEmpty {
                        sel_inds = "\(index + AppData.user.sport * 100)"
                    } else{
                        sel_inds = sel_inds + ",\(index + AppData.user.sport * 100)"
                    }
                }
            }
            if sel_strengths.count > 1 {
                if sel_strengths[1] == ss {
                    if sel_inds.isEmpty {
                        sel_inds = "\(index + AppData.user.sport * 100)"
                    } else{
                        sel_inds = sel_inds + ",\(index + AppData.user.sport * 100)"
                    }
                }
            }
            if sel_strengths.count > 2 {
                if sel_strengths[2] == ss {
                    if sel_inds.isEmpty {
                        sel_inds = "\(index + AppData.user.sport * 100)"
                    } else{
                        sel_inds = sel_inds + ",\(index + AppData.user.sport * 100)"
                    }
                }
            }
            index += 1
        }
        
        if !sel_inds.isEmpty{
            API.saveStrengths(data: sel_inds, onSuccess: { response in
                self.actionBack()
                
            }, onFailed: { err in
                self.showToast(message: err)
            })
        }
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        txt_search.text = ""
        filteredStrings = strengths
        table_view.reloadData()
    }
    
    func getAllStrengths(){
        hud.show(in: view)
        API.getStrengths(uid: AppData.user.id, onSuccess: { response in
            self.hud.dismiss()
            self.sel_strengths.removeAll()
            for ss in response {
                let iStrength = Int(ss)!
                let ind = iStrength - AppData.user.sport * 100
                if ind >= 0 && ind < self.strengths.count{
                    self.sel_strengths.append(self.strengths[ind])
                }
                self.table_view.reloadData()
            }
        }, onFailed: { err in
            self.hud.dismiss()
            self.showToast(message: err)
        })
    }
    
}

extension EditStrengthVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StrengthTVCell", for: indexPath) as! StrengthTVCell
        cell.lb_name.text = filteredStrings[indexPath.row]
        cell.view_bg.backgroundColor = UIColor.white
        for ss in sel_strengths {
            if ss == filteredStrings[indexPath.row]{
                cell.view_bg.backgroundColor = UIColor.from(hex: "FCF4D8")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sel_strengths.count == 3 {
            sel_strengths.remove(at: 0)
        }
        sel_strengths.append(filteredStrings[indexPath.row])
        tableView.reloadData()
    }
}

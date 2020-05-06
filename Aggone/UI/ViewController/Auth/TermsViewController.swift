//
//  TermsViewController.swift
//  Aggone
//
//  Created by tiexiong on 6/8/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet weak var text_terms: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text_terms.attributedText = getString(key: "terms_and_conditions").htmlToAttributedString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        actionBack()
    }
}

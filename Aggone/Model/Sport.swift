//
//  Sport.swift
//  Aggone
//
//  Created by tiexiong on 2/25/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import Foundation
import UIKit

public class Sport {
    public var id : Int!
    public var name : String = ""
    public var icon : UIImage!
    public var selected : Bool = false
    
    init() {}
    
    init(id: Int, name: String, icon: UIImage) {
        self.id = id
        self.name = name
        self.icon = icon
    }
}

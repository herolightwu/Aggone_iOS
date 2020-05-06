//
//  Prize.swift
//  Aggone
//
//  Created by tiexiong on 5/29/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation

public class Prize {
    public var id : String = ""
    public var user_id: String = ""
    public var year: String = ""
    public var club: String = ""
    public var title: String = ""
    public var icon: Int = 0
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "user_id" : user_id,
                "year" : year,
                "club" : club,
                "title" : title,
                "icon" : icon]
    }
    
    init() {}
    
    init(dictionary:[String:Any]) {
        for (key, value) in dictionary {
            if let _ = value as? NSNull {
                continue
            }
            switch key {
            case "id":
                self.id = "\(Utils.AnyToInt(value: value))"
            case "user_id":
                self.user_id = "\(Utils.AnyToInt(value: value))"
            case "year":
                self.year = "\(Utils.AnyToInt(value: value))"
            case "club":
                self.club = value as! String
            case "title":
                self.title = value as! String
            case "icon":
                self.icon = Utils.AnyToInt(value: value)
            default:
                break;
            }
        }
    }
}

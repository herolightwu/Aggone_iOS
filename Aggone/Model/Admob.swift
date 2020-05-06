//
//  Admob.swift
//  Aggone
//
//  Created by tiexiong on 5/24/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation

public class Admob {
    public var id : String = ""
    public var user : User!
    public var sport: Int = 0
    public var position: String = ""
    public var description: String = ""
    public var city: String = ""
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "user" : user.dictionary,
                "sport_id" : sport,
                "position" : position,
                "description" : description,
                "city" : city]
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
            case "user":
                self.user = User(dictionary: value as! [String:Any])
            case "sport_id":
                self.sport = Utils.AnyToInt(value: value)
            case "position":
                self.position = value as! String
            case "description":
                self.description = value as! String
            case "city":
                self.city = value as! String
            default:
                break;
            }
        }
    }
}

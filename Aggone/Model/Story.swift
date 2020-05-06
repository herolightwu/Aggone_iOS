//
//  Story.swift
//  Aggone
//
//  Created by MeiXiang Wu on 3/29/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import Foundation

public class Story {
    public var id       : String = ""
    public var user     : User!
    public var image    : String = ""
    public var timebeg  : Int64 = 0
    public var timeend  : Int64 = 0
    public var tags     : String = ""
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "user" : user.dictionary,
                "image" : image,
                "timebeg" : timebeg,
                "timeend" : timeend,
                "tags" : tags]
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
            case "image":
                self.image = value as! String
            case "timebeg":
                self.timebeg = Utils.AnyToInt64(value: value)
            case "timeend":
                self.timeend = Utils.AnyToInt64(value: value)
            case "tags":
                self.tags = value as! String
            default:
                break;
            }
        }
    }
}

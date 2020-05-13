//
//  StoryMsg.swift
//  Aggone
//
//  Created by MeiXiang Wu on 3/29/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import Foundation

public class StoryMsg {
    public var id       : String = ""
    public var user     : User!
    public var reply_type : Int = 0
    public var content  : String = ""
    public var timestamp  : Int64 = 0
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "user" : user.dictionary,
                "reply_type" : reply_type,
                "content" : content,
                "timestamp" : timestamp,
                ]
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
            case "reply_type":
                self.reply_type = Utils.AnyToInt(value: value)
            case "content":
                self.content = value as! String
            case "timestamp":
                self.timestamp = Utils.AnyToInt64(value: value)
            default:
                break;
            }
        }
    }
}

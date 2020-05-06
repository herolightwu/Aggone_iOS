//
//  StoryView.swift
//  Aggone
//
//  Created by MeiXiang Wu on 3/29/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import Foundation

public class StoryView {
    public var id           : String = ""
    public var story_id     : String = ""
    public var user         : User!
    public var reply_count  : Int = 0
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "story_id" : story_id,
                "user" : user.dictionary,
                "reply_count" : reply_count,
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
            case "story_id":
                self.story_id = "\(Utils.AnyToInt(value: value))"
            case "user":
                self.user = User(dictionary: value as! [String:Any])
            case "reply_count":
                self.reply_count = Utils.AnyToInt(value: value)
            default:
                break;
            }
        }
    }
}

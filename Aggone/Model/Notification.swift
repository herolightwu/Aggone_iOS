//
//  Notification.swift
//  Aggone
//
//  Created by APPLE on 2019/4/13.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import Foundation

public class Notification {
    public var id : String = ""
    public var type : String = ""
    public var content_msg : String = ""
    public var user : User!
    public var timestamp: Int64 = 0
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "type" : type,
                "content_mag" : content_msg,
                "sender" : user.dictionary,
                "timestamp" : timestamp]
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
            case "type":
                self.type = value as! String
            case "sender":
                self.user = User(dictionary: value as! [String:Any])
            case "timestamp":
                self.timestamp = Utils.AnyToInt64(value: value)
            case "content_msg":
                self.content_msg = value as! String
            default:
                break;
            }
        }
    }
}

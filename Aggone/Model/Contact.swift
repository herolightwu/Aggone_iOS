//
//  Contact.swift
//  Aggone
//
//  Created by APPLE on 2019/4/7.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import Foundation

public class Contact {
    public var id : String = ""
    public var message : String = ""
    public var type: Int = 0
    public var timestamp: Int64 = 0
    public var user: User!
    public var unread_count: Int = 0
    
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "message" : message,
                "type" : type,
                "timestamp" : timestamp,
                "user" : user.dictionary,
                "unread_count" : unread_count]
    }
    
    init() {}
    
    init(dictionary:[String:Any]) {
        for (key, value) in dictionary {
            if let _ = value as? NSNull {
                continue
            }
            switch key {
            case "id":
                self.id = value as! String
            case "message":
                self.message = value as! String
            case "user":
                self.user = User(dictionary: value as! [String:Any])
            case "timestamp":
                self.timestamp = Utils.AnyToInt64(value: value)
            case "type":
                self.type = Utils.AnyToInt(value: value)
            case "unread_count":
                self.unread_count = Utils.AnyToInt(value: value)
            default:
                break;
            }
        }
    }
}

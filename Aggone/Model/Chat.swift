//
//  Chat.swift
//  Aggone
//
//  Created by tiexiong on 5/25/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation

public class Chat {
    public var id : String = ""
    public var type : Int = 0
    public var sender : String = ""
    public var message: String = ""
    public var timestamp: Int64 = 0
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "type" : type,
                "sender" : sender,
                "message" : message,
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
                self.id = value as! String
            case "type":
                self.type = Utils.AnyToInt(value: value)
            case "sender":
                self.sender = value as! String
            case "message":
                self.message = value as! String
            case "timestamp":
                self.timestamp = Utils.AnyToInt64(value: value)
            default:
                break;
            }
        }
    }
}

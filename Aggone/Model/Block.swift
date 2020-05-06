//
//  Block.swift
//  Aggone
//
//  Created by tiexiong on 6/11/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import Foundation

public class Block {
    public var id : String = ""
    public var user_id : String = ""
    public var blocked_user_id : String = ""
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "user_id" : user_id,
                "blocked_user_id" : blocked_user_id]
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
            case "blocked_user_id":
                self.blocked_user_id = "\(Utils.AnyToInt(value: value))"
            default:
                break;
            }
        }
    }
}

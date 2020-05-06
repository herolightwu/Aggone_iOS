//
//  Description.swift
//  Aggone
//
//  Created by tiexiong on 3/22/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import Foundation

public class Description {
    public var id: Int = 0
    public var user_id: String = ""
    public var type: Int = 0
    public var value: Int = 0
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "user_id" : user_id,
                "type" : type,
                "value" : value]
    }
    
    init() {}
    
    init(dictionary:[String:Any]) {
        for (key, value) in dictionary {
            if let _ = value as? NSNull {
                continue
            }
            switch key {
            case "id":
                self.id = value as! Int
            case "user_id":
                self.user_id = "\(Utils.AnyToInt(value: value))"
            case "type":
                self.type = Utils.AnyToInt(value: value)
            case "value":
                self.value = Utils.AnyToInt(value: value)
            default:
                break;
            }
        }
    }
}

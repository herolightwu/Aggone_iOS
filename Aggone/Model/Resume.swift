//
//  Resume.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/7/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import Foundation

public class Resume {
    public var id : String = "";
    public var user_id : String = "";
    public var resume_url : String = "";
    
    var dictionary: [String:Any] {
        return ["id" : id,
                "user_id" : user_id,
                "resume_url" : resume_url]
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
            case "resume_url":
                self.resume_url = value as! String
            default:
                break;
            }
        }
    }
}
